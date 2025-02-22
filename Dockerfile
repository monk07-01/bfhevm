FROM golang:1.18-alpine3.17 AS builder

WORKDIR /opt

ENV PACKAGES git build-base linux-headers bash binutils-gold

RUN apk add --update $PACKAGES

ENV COMMIT_HASH=tokenfactory-gravity-evm

RUN git clone https://github.com/monk07-01/bfhevm.git \
    && cd bfhevm \
    && git checkout ${COMMIT_HASH}


WORKDIR /opt/bfhevm

RUN make build

#RUN go install github.com/MinseokOh/toml-cli@latest

FROM alpine:3.17

COPY --from=builder /opt/bfhevm/build/bfhevmd /usr/local/bin/

RUN apk add --update bash vim ca-certificates \
    && addgroup -g 1000 bfhevm \
    && adduser -S -h /home/bfhevm -D bfhevm -u 1000 -G bfhevm


#COPY --from=build-env /go/src/github.com/monk07-01/bfhevm/build/bfhevmd /usr/bin/bfhevmd
#COPY --from=build-env /go/bin/toml-cli /usr/bin/toml-cli


# required for rocksdb build
#COPY --from=build-env /target/usr/lib /usr/lib
#COPY --from=build-env /target/usr/local/lib /usr/local/lib
#COPY --from=build-env /target/usr/include /usr/include

USER 1000

WORKDIR /home/bfhevm

EXPOSE 26656 26657 1317 9090 8545 8546
HEALTHCHECK CMD curl --fail http://localhost:26657 || exit 1

CMD ["bfhevmd", "start"]
