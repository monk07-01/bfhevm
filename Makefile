#!/usr/bin/make -f

PACKAGES=$(shell go list ./... | grep -v '/simulation')
VERSION := $(shell echo $(shell git describe --tags 2>/dev/null ) | sed 's/^v//')
COMMIT := $(shell git log -1 --format='%H')
LEDGER_ENABLED ?= true
HTTPS_GIT := https://github.com/monk07-01/bfhevm.git
BUILDDIR ?= $(CURDIR)/build
COVERAGE ?= coverage.txt

GOPATH ?= $(shell $(GO) env GOPATH)
BINDIR ?= ~/go/bin
BFHEVM_BINARY = bfhevmd
BFHEVM_DIR = bfhevm
NETWORK ?= mainnet

DOCKER := $(shell which docker)
DOCKER_BUILDKIT=1
DOCKER_ARGS=
ifdef GITHUB_TOKEN
	ifneq ($(strip $(GITHUB_TOKEN)),)
		DOCKER_ARGS += --secret id=GITHUB_TOKEN
	endif
endif

NAMESPACE := monk07-01
PROJECT := bfhevm
DOCKER_IMAGE := $(PROJECT)/node
COMMIT_HASH := $(shell git rev-parse --short=7 HEAD)
DOCKER_TAG := $(COMMIT_HASH)

TESTNET_FLAGS ?=

export GO111MODULE = on

default_target: all

.PHONY: default_target


# process build tags
build_tags = netgo
ifeq ($(NETWORK),mainnet)
    build_tags += mainnet
else ifeq ($(NETWORK),testnet)
    build_tags += testnet
endif

ifeq ($(LEDGER_ENABLED),true)
    ifeq ($(OS),Windows_NT)
        GCCEXE = $(shell where gcc.exe 2> NUL)
        ifeq ($(GCCEXE),)
            $(error gcc.exe not installed for ledger support, please install or set LEDGER_ENABLED=false)
        else
            build_tags += ledger
        endif
    else
        UNAME_S = $(shell uname -s)
        ifeq ($(UNAME_S),OpenBSD)
            $(warning OpenBSD detected, disabling ledger support (https://github.com/cosmos/cosmos-sdk/issues/1988))
        else
            GCC = $(shell command -v gcc 2> /dev/null)
            ifeq ($(GCC),)
                $(error gcc not installed for ledger support, please install or set LEDGER_ENABLED=false)
            else
                build_tags += ledger
            endif
        endif
    endif
endif

# DB backend selection
ifeq (cleveldb,$(findstring cleveldb,$(COSMOS_BUILD_OPTIONS)))
  ldflags += -X github.com/cosmos/cosmos-sdk/types.DBBackend=cleveldb
endif
ifeq (badgerdb,$(findstring badgerdb,$(COSMOS_BUILD_OPTIONS)))
  ldflags += -X github.com/cosmos/cosmos-sdk/types.DBBackend=badgerdb
  build_tags += badgerdb
endif
# handle rocksdb
ifeq (rocksdb,$(findstring rocksdb,$(COSMOS_BUILD_OPTIONS)))
  $(info ################################################################)
  $(info To use rocksdb, you need to install rocksdb first)
  $(info Please follow this guide https://github.com/rockset/rocksdb-cloud/blob/master/INSTALL.md)
  $(info ################################################################)
  CGO_ENABLED=1
  build_tags += rocksdb
  ldflags += -X github.com/cosmos/cosmos-sdk/types.DBBackend=rocksdb
endif
# handle boltdb
ifeq (boltdb,$(findstring boltdb,$(COSMOS_BUILD_OPTIONS)))
  build_tags += boltdb
  ldflags += -X github.com/cosmos/cosmos-sdk/types.DBBackend=boltdb
endif

build_tags += $(BUILD_TAGS)
build_tags := $(strip $(build_tags))

whitespace := $(subst ,, )
comma := ,
build_tags_comma_sep := $(subst $(whitespace),$(comma),$(build_tags))

# process linker flags
ldflags += -X github.com/cosmos/cosmos-sdk/version.Name=bfhevm \
        -X github.com/cosmos/cosmos-sdk/version.AppName=bfhevmd \
        -X github.com/cosmos/cosmos-sdk/version.Version=$(VERSION) \
        -X github.com/cosmos/cosmos-sdk/version.Commit=$(COMMIT) \
        -X github.com/cosmos/cosmos-sdk/version.BuildTags=$(build_tags_comma_sep)

ifeq (,$(findstring nostrip,$(COSMOS_BUILD_OPTIONS)))
  ldflags += -w -s
endif
ldflags += $(LDFLAGS)
ldflags := $(strip $(ldflags))

BUILD_FLAGS := -tags "$(build_tags)" -ldflags '$(ldflags)'
# check for nostrip option
ifeq (,$(findstring nostrip,$(COSMOS_BUILD_OPTIONS)))
  BUILD_FLAGS += -trimpath
endif

# check if no optimization option is passed
# used for remote debugging
ifneq (,$(findstring nooptimization,$(COSMOS_BUILD_OPTIONS)))
  BUILD_FLAGS += -gcflags "all=-N -l"
endif

# # The below include contains the tools and runsim targets.
# include contrib/devtools/Makefile


###############################################################################
###                                Build                                    ###
###############################################################################

BUILD_TARGETS := build install

build: BUILD_ARGS=-o $(BUILDDIR)/

build-linux:
	GOOS=linux GOARCH=arm64 LEDGER_ENABLED=false $(MAKE) build

$(BUILD_TARGETS): go.sum $(BUILDDIR)/
	CGO_ENABLED="1" go $@ $(BUILD_FLAGS) $(BUILD_ARGS) ./...

$(BUILDDIR)/:
	mkdir -p $(BUILDDIR)/

docker-build:
	# TODO replace with kaniko
	docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
	docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest
	# docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:${COMMIT_HASH}
	# update old container
	docker rm bfhevm || true
	# create a new container from the latest image
	docker create --name bfhevm -t -i bfhevm/node:latest bfhevm
	# move the binaries to the ./build directory
	mkdir -p ./build/
	docker cp bfhevm:/usr/bin/bfhevmd ./build/

$(MOCKS_DIR):
	mkdir -p $(MOCKS_DIR)

distclean: clean tools-clean

clean:
	rm -rf \
    $(BUILDDIR)/ \
    artifacts/ \
    tmp-swagger-gen/

all: build

build-all: tools build lint test

.PHONY: distclean clean build-all


###############################################################################
###                                Linting                                  ###
###############################################################################

lint:
	go mod verify
	golangci-lint run --out-format=tab

lint-fix:
	golangci-lint run --fix --out-format=tab --issues-exit-code=0

lint-py:
	flake8 --show-source --count --statistics \
          --format="::error file=%(path)s,line=%(row)d,col=%(col)d::%(path)s:%(row)d:%(col)d: %(code)s %(text)s" \

lint-nix:
	find . -name "*.nix" ! -path './integration_tests/contracts/*' ! -path "./contracts/*" | xargs nixpkgs-fmt --check

.PHONY: lint lint-fix lint-py

###############################################################################
###                                Releasing                                ###
###############################################################################

PACKAGE_NAME:=github.com/monk07-01/bfhevm
GOLANG_CROSS_VERSION  = v1.18
release-dry-run:
	docker run \
		--rm \
		--privileged \
		-e CGO_ENABLED=1 \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v `pwd`:/go/src/$(PACKAGE_NAME) \
		-v ${GOPATH}/pkg:/go/pkg \
		-w /go/src/$(PACKAGE_NAME) \
		ghcr.io/goreleaser/goreleaser-cross:${GOLANG_CROSS_VERSION} \
		--rm-dist --skip-validate --skip-publish

release:
	@if [ ! -f ".release-env" ]; then \
		echo "\033[91m.release-env is required for release\033[0m";\
		exit 1;\
	fi
	docker run \
		--rm \
		--privileged \
		-e CGO_ENABLED=1 \
		--env-file .release-env \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v `pwd`:/go/src/$(PACKAGE_NAME) \
		-w /go/src/$(PACKAGE_NAME) \
		ghcr.io/goreleaser/goreleaser-cross:${GOLANG_CROSS_VERSION} \
		release --rm-dist --skip-validate

.PHONY: release-dry-run release

###############################################################################
###                                Sim Test                                 ###
###############################################################################

SIMAPP = github.com/monk07-01/bfhevm/app

# Install the runsim binary with a temporary workaround of entering an outside
# directory as the "go get" command ignores the -mod option and will polute the
# go.{mod, sum} files.
#
# ref: https://github.com/golang/go/issues/30515
runsim: $(BINDIR)/runsim
$(BINDIR)/runsim:
	@echo "Installing runsim..."
	@(cd /tmp && go install github.com/cosmos/tools/cmd/runsim@v1.0.0)

test-sim-nondeterminism:
	@echo "Running non-determinism test..."
	@go test -mod=readonly $(SIMAPP) -run TestAppStateDeterminism -Enabled=true \
		-NumBlocks=100 -BlockSize=200 -Commit=true -Period=0 -v -timeout 24h

test-sim-random-genesis-fast:
	@echo "Running random genesis simulation..."
	@go test -mod=readonly $(SIMAPP) -run TestFullAppSimulation \
		-Enabled=true -NumBlocks=100 -BlockSize=200 -Commit=true -Seed=99 -Period=5 -v -timeout 24h

test-sim-import-export: runsim
	@echo "Running application import/export simulation. This may take several minutes..."
	@$(BINDIR)/runsim -Jobs=4 -SimAppPkg=$(SIMAPP) -ExitOnFail 50 5 TestAppImportExport

test-sim-after-import: runsim
	@echo "Running application simulation-after-import. This may take several minutes..."
	@$(BINDIR)/runsim -Jobs=4 -SimAppPkg=$(SIMAPP) -ExitOnFail 50 5 TestAppSimulationAfterImport

test-sim-custom-genesis-multi-seed: runsim
	@echo "Running multi-seed custom genesis simulation..."
	@echo "By default, ${HOME}/.bfhevmd/config/genesis.json will be used."
	@$(BINDIR)/runsim -Genesis=${HOME}/.bfhevmd/config/genesis.json -SimAppPkg=$(SIMAPP) -ExitOnFail 400 5 TestFullAppSimulation

test-sim-multi-seed-long: runsim
	@echo "Running long multi-seed application simulation. This may take awhile!"
	@$(BINDIR)/runsim -Jobs=4 -SimAppPkg=$(SIMAPP) -ExitOnFail 500 50 TestFullAppSimulation

test-sim-multi-seed-short: runsim
	@echo "Running short multi-seed application simulation. This may take awhile!"
	@$(BINDIR)/runsim -Jobs=4 -SimAppPkg=$(SIMAPP) -ExitOnFail 50 10 TestFullAppSimulation

test-sim-benchmark-invariants:
	@echo "Running simulation invariant benchmarks..."
	@go test -mod=readonly $(SIMAPP) -benchmem -bench=BenchmarkInvariants -run=^$ \
	-Enabled=true -NumBlocks=1000 -BlockSize=200 \
	-Period=1 -Commit=true -Seed=57 -v -timeout 24h

.PHONY: \
test-sim-nondeterminism \
test-sim-custom-genesis-fast \
test-sim-import-export \
test-sim-after-import \
test-sim-custom-genesis-multi-seed \
test-sim-multi-seed-short \
test-sim-multi-seed-long \
test-sim-benchmark-invariants

SIM_NUM_BLOCKS ?= 500
SIM_BLOCK_SIZE ?= 200
SIM_COMMIT ?= true

test-sim-benchmark:
	@echo "Running application benchmark for numBlocks=$(SIM_NUM_BLOCKS), blockSize=$(SIM_BLOCK_SIZE). This may take awhile!"
	@go test -mod=readonly -benchmem -run=^$$ $(SIMAPP) -bench ^BenchmarkFullAppSimulation$$  \
		-Enabled=true -NumBlocks=$(SIM_NUM_BLOCKS) -BlockSize=$(SIM_BLOCK_SIZE) -Commit=$(SIM_COMMIT) -timeout 24h

test-sim-profile:
	@echo "Running application benchmark for numBlocks=$(SIM_NUM_BLOCKS), blockSize=$(SIM_BLOCK_SIZE). This may take awhile!"
	@go test -mod=readonly -benchmem -run=^$$ $(SIMAPP) -bench ^BenchmarkFullAppSimulation$$ \
		-Enabled=true -NumBlocks=$(SIM_NUM_BLOCKS) -BlockSize=$(SIM_BLOCK_SIZE) -Commit=$(SIM_COMMIT) -timeout 24h -cpuprofile cpu.out -memprofile mem.out

.PHONY: test-sim-profile test-sim-benchmark


###############################################################################
###                                Localnet                                 ###
###############################################################################

# Build image for a local testnet
localnet-build:
	@$(MAKE) -C networks/local

# Start a 4-node testnet locally
localnet-start: localnet-stop
ifeq ($(OS),Windows_NT)
	mkdir localnet-setup &
	@$(MAKE) localnet-build

	IF not exist "build/node0/$(BFHEVM_BINARY)/config/genesis.json" docker run --rm -v $(CURDIR)/build\bfhevm\Z bfhev/node "./bfhevmd testnet --v 4 -o /bfhevm --keyring-backend=test --ip-addresses bfhevmnode0,bfhevmnode1,bfhevmnode2,bfhevmnode3"
	docker-compose up -d
else
	mkdir -p localnet-setup
	@$(MAKE) localnet-build

	if ! [ -f localnet-setup/node0/$(BFHEVM_BINARY)/config/genesis.json ]; then docker run --rm -v $(CURDIR)/localnet-setup:/bfhevm:Z bfhevm/node "./bfhevmd testnet --v 4 -o /bfhevm --keyring-backend=test --ip-addresses bfhevmnode0,bfhevmnode1,bfhevmnode2,bfhevmnode3"; fi
	docker-compose up -d
endif

# Stop testnet
localnet-stop:
	docker-compose down

# Clean testnet
localnet-clean:
	docker-compose down
	sudo rm -rf localnet-setup
 # Reset testnet
localnet-unsafe-reset:
	docker-compose down
ifeq ($(OS),Windows_NT)
	@docker run --rm -v $(CURDIR)\localnet-setup\node0\bfhevmd:/bfhevm\Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
	@docker run --rm -v $(CURDIR)\localnet-setup\node1\bfhevmd:/bfhevm\Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
	@docker run --rm -v $(CURDIR)\localnet-setup\node2\bfhevmd:/bfhevm\Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
	@docker run --rm -v $(CURDIR)\localnet-setup\node3\bfhevmd:/bfhevm\Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
else
	@docker run --rm -v $(CURDIR)/localnet-setup/node0/bfhevmd:/bfhevm:Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
	@docker run --rm -v $(CURDIR)/localnet-setup/node1/bfhevmd:/bfhevm:Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
	@docker run --rm -v $(CURDIR)/localnet-setup/node2/bfhevmd:/bfhevm:Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
	@docker run --rm -v $(CURDIR)/localnet-setup/node3/bfhevmd:/bfhevm:Z bfhevm/node "./bfhevmd tendermint unsafe-reset-all --home=/bfhevm"
endif

# Show stream of logs
localnet-show-logstream:
	docker-compose logs --tail=1000 -f

.PHONY: build-docker-local-bfhevm localnet-start localnet-stop

###############################################################################
###                                Integration Test                         ###
###############################################################################

run-integration-tests:
	@nix-shell ./integration_tests/shell.nix --run ./scripts/run-integration-tests

.PHONY: run-integration-tests

###############################################################################
###                                Utility                                  ###
###############################################################################

test-cronos-contracts:
	@git submodule update --init --recursive
	@nix-shell ./contracts/shell.nix --pure --run ./scripts/test-cronos-contracts

gen-cronos-contracts:
	@git submodule update --init --recursive
	@nix-shell ./contracts/shell.nix --pure --run ./scripts/gen-cronos-contracts

.PHONY: gen-cronos-contracts test-cronos-contracts

check-network:
ifeq ($(NETWORK),mainnet)
else ifeq ($(NETWORK),testnet)
else
	@echo "Unrecognized network: ${NETWORK}"
endif
	@echo "building network: ${NETWORK}"

print-ledger:
ifeq ($(LEDGER_ENABLED),true)
	@echo "building with ledger support"
endif

###############################################################################
###                                Protobuf                                 ###
###############################################################################

HTTPS_GIT := https://github.com/monk07-01/bfhevm.git
DOCKER := $(shell which docker)
DOCKER_BUF := $(DOCKER) run --rm -v $(CURDIR):/workspace --workdir /workspace bufbuild/buf

containerProtoVer=v0.3
containerProtoImage=tendermintdev/sdk-proto-gen:$(containerProtoVer)
containerProtoGen=cosmos-sdk-proto-gen-$(containerProtoVer)
containerProtoGenSwagger=cosmos-sdk-proto-gen-swagger-$(containerProtoVer)
containerProtoFmt=cosmos-sdk-proto-fmt-$(containerProtoVer)

proto-all: proto-format proto-lint proto-gen

proto-gen:
	@echo "Generating Protobuf files"
	$(DOCKER) run --rm -v $(CURDIR):/workspace --workdir /workspace $(containerProtoImage) sh ./scripts/protocgen.sh

proto-swagger-gen:
	@echo "Generating Protobuf Swagger"
	$(DOCKER) run --rm -v $(CURDIR):/workspace --workdir /workspace $(containerProtoImage) sh ./scripts/protoc-swagger-gen.sh

proto-format:
	@echo "Formatting Protobuf files"
	find ./ -not -path "./third_party/*" -name *.proto -exec clang-format -i {} \;

proto-lint:
	@$(DOCKER_BUF) lint --error-format=json

proto-check-breaking:
	@$(DOCKER_BUF) breaking --against $(HTTPS_GIT)#branch=main


TM_URL              = https://raw.githubusercontent.com/tendermint/tendermint/v0.34.12/proto/tendermint
GOGO_PROTO_URL      = https://raw.githubusercontent.com/regen-network/protobuf/cosmos
COSMOS_SDK_URL      = https://raw.githubusercontent.com/cosmos/cosmos-sdk/v0.44.0
COSMOS_PROTO_URL    = https://raw.githubusercontent.com/regen-network/cosmos-proto/master

TM_CRYPTO_TYPES     = third_party/proto/tendermint/crypto
TM_ABCI_TYPES       = third_party/proto/tendermint/abci
TM_TYPES            = third_party/proto/tendermint/types

GOGO_PROTO_TYPES    = third_party/proto/gogoproto

COSMOS_PROTO_TYPES  = third_party/proto/cosmos_proto

proto-update-deps:
	@mkdir -p $(GOGO_PROTO_TYPES)
	@curl -sSL $(GOGO_PROTO_URL)/gogoproto/gogo.proto > $(GOGO_PROTO_TYPES)/gogo.proto

	@mkdir -p $(COSMOS_PROTO_TYPES)
	@curl -sSL $(COSMOS_PROTO_URL)/cosmos.proto > $(COSMOS_PROTO_TYPES)/cosmos.proto

## Importing of tendermint protobuf definitions currently requires the
## use of `sed` in order to build properly with cosmos-sdk's proto file layout
## (which is the standard Buf.build FILE_LAYOUT)
## Issue link: https://github.com/tendermint/tendermint/issues/5021
	@mkdir -p $(TM_ABCI_TYPES)
	@curl -sSL $(TM_URL)/abci/types.proto > $(TM_ABCI_TYPES)/types.proto

	@mkdir -p $(TM_TYPES)
	@curl -sSL $(TM_URL)/types/types.proto > $(TM_TYPES)/types.proto

	@mkdir -p $(TM_CRYPTO_TYPES)
	@curl -sSL $(TM_URL)/crypto/proof.proto > $(TM_CRYPTO_TYPES)/proof.proto
	@curl -sSL $(TM_URL)/crypto/keys.proto > $(TM_CRYPTO_TYPES)/keys.proto

.PHONY: proto-all proto-gen proto-format proto-lint proto-check-breaking proto-update-deps

###############################################################################
###                              Documentation                              ###
###############################################################################

update-swagger-docs: statik
	$(BINDIR)/statik -src=client/docs/swagger-ui -dest=client/docs -f -m
	@if [ -n "$(git status --porcelain)" ]; then \
        echo "\033[91mSwagger docs are out of sync!!!\033[0m";\
        exit 1;\
    else \
        echo "\033[92mSwagger docs are in sync\033[0m";\
    fi
.PHONY: update-swagger-docs

godocs:
	@echo "--> Wait a few seconds and visit http://localhost:6080/pkg/github.com/monk07-01/bfhevm"
	godoc -http=:6080
