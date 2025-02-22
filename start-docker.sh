#!/bin/sh

KEY="monk"
CHAINID="bfhevm_777-1"
MONIKER="mymoniker"
DATA_DIR=$HOME
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# trace evm
TRACE="--trace"
# TRACE=""

echo "create and add new keys"
bfhevmd keys add $KEY --algo "eth_secp256k1" --keyring-backend test
echo "init Bfhevm with moniker=$MONIKER and chain-id=$CHAINID"
bfhevmd init $MONIKER --chain-id "$CHAINID"
# Change parameter token denominations to abfh
perl -i -pe 's/^minimum-gas-prices = ".*?"/minimum-gas-prices = "0.01abfh"/' ~/.bfhevm/config/app.toml
cat $HOME/.bfhevm/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="abfh"' > $HOME/.bfhevm/config/tmp_genesis.json && mv $HOME/.bfhevm/config/tmp_genesis.json $HOME/.bfhevm/config/genesis.json
cat $HOME/.bfhevm/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="abfh"' > $HOME/.bfhevm/config/tmp_genesis.json && mv $HOME/.bfhevm/config/tmp_genesis.json $HOME/.bfhevm/config/genesis.json
cat $HOME/.bfhevm/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="abfh"' > $HOME/.bfhevm/config/tmp_genesis.json && mv $HOME/.bfhevm/config/tmp_genesis.json $HOME/.bfhevm/config/genesis.json
cat $HOME/.bfhevm/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="abfh"' > $HOME/.bfhevm/config/tmp_genesis.json && mv $HOME/.bfhevm/config/tmp_genesis.json $HOME/.bfhevm/config/genesis.json


sed -i 's/prometheus = false/prometheus = true/g' $HOME/.bfhevm/config/config.toml
sed -i 's/enable-indexer = false/enable-indexer = true/g' $HOME/.bfhevm/config/app.toml
perl -i -0pe 's/# Enable defines if the API server should be enabled.\nenable = false/# Enable defines if the API server should be enabled.\nenable = true/' $HOME/.bfhevm/config/app.toml

sed -i 's/timeout_commit = "5s"/timeout_commit = "3s"/g' "$CONFIG"
# make sure the localhost IP is 0.0.0.0
sed -i 's/pprof_laddr = "localhost:6060"/pprof_laddr = "0.0.0.0:6060"/g' $HOME/.bfhevm/config/config.toml
sed -i 's/127.0.0.1/0.0.0.0/g' $HOME/.bfhevm/config/app.toml
sed -i 's/localhost/0.0.0.0/g' $HOME/.bfhevm/config/app.toml
# Set gas limit in genesis
cat $HOME/.bfhevm/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="20000000"' > $HOME/.bfhevm/config/tmp_genesis.json && mv $HOME/.bfhevm/config/tmp_genesis.json $HOME/.bfhevm/config/genesis.json
echo "prepare genesis: Allocate genesis accounts"
bfhevmd add-genesis-account $KEY 100000000000000000000000000abfh --keyring-backend test
echo "prepare genesis: Sign genesis transaction"
bfhevmd gentx $KEY 1000000000000000000000abfh --keyring-backend $KEYRING --chain-id $CHAINID
echo "prepare genesis: Collect genesis tx"
bfhevmd collect-gentxs
echo "prepare genesis: Run validate-genesis to ensure everything worked and that the genesis file is setup correctly"
# Run this to ensure everything worked and that the genesis file is setup correctly
bfhevmd validate-genesis

echo "starting bfhevm node in background ..."
bfhevmd start --pruning=nothing --rpc.unsafe \
        --keyring-backend test --home "$DATA_DIR" \
        >"$DATA_DIR"/node.log 2>&1 &
disown

echo "started bfhevm node"
tail -f /dev/null

