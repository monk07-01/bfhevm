
ARG GO_VERSION="1.18"
ARG RUNNER_IMAGE="gcr.io/distroless/static-debian11"
ARG BUILD_TAGS="netgo,ledger,muslc"


FROM golang:${GO_VERSION}-alpine3.20 AS build-env

ARG NETWORK=testnet
ARG BUILD_TAGS
#Set Dependencies
ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python3

WORKDIR /osmosis
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/root/go/pkg/mod \
    go mod download

# Install dependencies
RUN apk add --update $PACKAGES
RUN apk add --no-cache \
    ca-certificates \
    build-base \
    linux-headers

# add source files
COPY . .

# Build osmosisd binary
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/root/go/pkg/mod \
    GOWORK=off go build \
    -mod=readonly \
    -tags "netgo,ledger,muslc" \
    -ldflags \
    "-X github.com/cosmos/cosmos-sdk/version.Name="bfhevm" \
    -X github.com/cosmos/cosmos-sdk/version.AppName="bfhevmd" \
    -X github.com/cosmos/cosmos-sdk/version.Version=${GIT_VERSION} \
    -X github.com/cosmos/cosmos-sdk/version.Commit=${GIT_COMMIT} \
    -X github.com/cosmos/cosmos-sdk/version.BuildTags=${BUILD_TAGS} \
    -w -s -linkmode=external -extldflags '-Wl,-z,muldefs -static'" \
    -trimpath \
    -o /bfhevm/build/bfhevmd \
    /bfhevm/cmd/bfhevmd/main.go

RUN make install

# Final image
FROM ${RUNNER_IMAGE}

# Copy over binaries from the build-env
COPY --from=build-env /bfhevm/build/bfhevmd /bin/bfhevmd

ENV HOME=/bfhevm
WORKDIR $HOME

EXPOSE 26660 26657 9091 8545 8546

# Run chain-maind by default, omit entrypoint to ease using container with chain-maincli
ENTRYPOINT ["bfhevmd"]

