FROM golang:alpine AS build-env

ARG NETWORK=testnet

#Set Dependencies
ENV PACKAGES curl make git libc-dev bash gcc linux-headers eudev-dev python3

#setup working directory for the build
WORKDIR /go/src/github.com/monk07-01/bfhevm

# Install dependencies
RUN apk add --update $PACKAGES
RUN apk add linux-headers

# add source files
COPY . .

RUN make install
# Final image
FROM alpine:3.17.3

ENV BFHEVM /bfhevm

# Install ca-certificates
RUN apk add --update ca-certificates
WORKDIR /

# Copy over binaries from the build-env
COPY --from=build-env /go/src/github.com/monk07-01/bfhevm /usr/bin/bfhevmd

# Run chain-maind by default, omit entrypoint to ease using container with chain-maincli
CMD ["bfhevmd"]

