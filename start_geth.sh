#!/usr/bin/env sh

if [ "$#" -eq 0 ]; then
    echo "Missing required argument: genesis-file"
    exit 1
fi

cp "${1}" /data/ewasm-node/4201/ewasm-testnet-geth-config.json
shift

geth \
    --vm.ewasm="/libhera.so,metering=true,fallback=true" \
    --datadir /data/ewasm-node/4201/ \
    --rpc --rpcapi "web3,net,eth,debug" \
    --rpcvhosts="*" --rpcaddr "0.0.0.0" \
    --rpccorsdomain "*" \
    --vmodule "miner=12,rpc=12" \
    --mine --miner.threads 1 \
    --nodiscover \
    --networkid 66 \
    --bootnodes "enode://53458e6bf0353f3378e115034cf6c6039b9faed52548da9030b37b4672de4a8fd09f869c48d16f9f10937e7398ae0dbe8b9d271408da7a0cf47f42a09e662827@23.101.78.254:30303" $@
