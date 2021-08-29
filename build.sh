#!/usr/bin/env bash

# Build script for ewasm go-client Dockerfile

if [ ! -d go-ethereum ]; then
    git clone https://github.com/ewasm/go-ethereum -b ewasm-testnet-milestone1
fi
if [ ! -d hera ]; then
    git clone https://github.com/ewasm/hera --recursive -b ewasm-testnet-milestone1
fi

docker build ${DOCKER_ARGS} -t pblair/ethereum-ewasm-testnet .

