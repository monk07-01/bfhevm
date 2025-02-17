#!/bin/bash
set -e

KEY1="validator1"
KEY2="validator2"
KEY3="validator3"
KEY4="validator4"
CHAINID="bfhevm_778-5"
#CHAINID2="bfhevm_777-2"
#CHAINID3="bfhevm_777-3"
#CHAINID4="bfhevm_777-4"
MONIKER="localtestnet"
KEYRING="test"
KEYALGO="eth_secp256k1"
LOGLEVEL="info"
# trace evm
TRACE="--trace"
# TRACE=""

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }


# always returns true so set -e doesn't exit if it is not running.
#killall bfhevmd || true
rm -rf $HOME/.bfhevm/

make install

# make four osmosis directories
mkdir $HOME/.bfhevm
mkdir $HOME/.bfhevm/validator1
mkdir $HOME/.bfhevm/validator2
mkdir $HOME/.bfhevm/validator3
mkdir $HOME/.bfhevm/validator4

# init all four validators
bfhevmd init $MONIKER --chain-id $CHAINID  --home=$HOME/.bfhevm/validator1
bfhevmd init $MONIKER --chain-id $CHAINID  --home=$HOME/.bfhevm/validator2
bfhevmd init $MONIKER --chain-id $CHAINID  --home=$HOME/.bfhevm/validator3
bfhevmd init $MONIKER --chain-id $CHAINID  --home=$HOME/.bfhevm/validator4
# create keys for all four validators
bfhevmd keys add $KEY1 --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator1
bfhevmd keys add $KEY2 --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator2
bfhevmd keys add $KEY3 --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator3
bfhevmd keys add $KEY4 --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator4


# Change parameter token denominations to abfh
perl -i -pe 's/^minimum-gas-prices = ".*?"/minimum-gas-prices = "0.01abfh"/' ~/.bfhevm/validator1/config/app.toml
cat $HOME/.bfhevm/validator1/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="abfh"' > $HOME/.bfhevm/validator1/config/tmp_genesis.json && mv $HOME/.bfhevm/validator1/config/tmp_genesis.json $HOME/.bfhevm/validator1/config/genesis.json
cat $HOME/.bfhevm/validator1/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="abfh"' > $HOME/.bfhevm/validator1/config/tmp_genesis.json && mv $HOME/.bfhevm/validator1/config/tmp_genesis.json $HOME/.bfhevm/validator1/config/genesis.json
cat $HOME/.bfhevm/validator1/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="abfh"' > $HOME/.bfhevm/validator1/config/tmp_genesis.json && mv $HOME/.bfhevm/validator1/config/tmp_genesis.json $HOME/.bfhevm/validator1/config/genesis.json
cat $HOME/.bfhevm/validator1/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="abfh"' > $HOME/.bfhevm/validator1/config/tmp_genesis.json && mv $HOME/.bfhevm/validator1/config/tmp_genesis.json $HOME/.bfhevm/validator1/config/genesis.json
cat $HOME/.bfhevm/validator1/config/genesis.json | jq '.app_state["cronos"]["params"]["ibc_cro_denom"]="ibc/7A1B557AE1BE5R82A1R3TYY44715G1G5241567GHT5H84814G845TR157SVA1759"' > $HOME/.bfhevm/validator1/config/tmp_genesis.json && mv $HOME/.bfhevm/validator1/config/tmp_genesis.json $HOME/.bfhevm/validator1/config/genesis.json
cat $HOME/.bfhevm/validator1/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="abfh"' > $HOME/.bfhevm/validator1/config/tmp_genesis.json && mv $HOME/.bfhevm/validator1/config/tmp_genesis.json $HOME/.bfhevm/validator1/config/genesis.json


# Set gas limit in genesis
cat $HOME/.bfhevm/validator1/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="20000000"' > $HOME/.bfhevm/validator1/config/tmp_genesis.json && mv $HOME/.bfhevm/validator1/config/tmp_genesis.json $HOME/.bfhevm/validator1/config/genesis.json

# Change parameter token denominations to abfh
perl -i -pe 's/^minimum-gas-prices = ".*?"/minimum-gas-prices = "0.01abfh"/' ~/.bfhevm/validator2/config/app.toml
cat $HOME/.bfhevm/validator2/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="abfh"' > $HOME/.bfhevm/validator2/config/tmp_genesis.json && mv $HOME/.bfhevm/validator2/config/tmp_genesis.json $HOME/.bfhevm/validator2/config/genesis.json
cat $HOME/.bfhevm/validator2/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="abfh"' > $HOME/.bfhevm/validator2/config/tmp_genesis.json && mv $HOME/.bfhevm/validator2/config/tmp_genesis.json $HOME/.bfhevm/validator2/config/genesis.json
cat $HOME/.bfhevm/validator2/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="abfh"' > $HOME/.bfhevm/validator2/config/tmp_genesis.json && mv $HOME/.bfhevm/validator2/config/tmp_genesis.json $HOME/.bfhevm/validator2/config/genesis.json
cat $HOME/.bfhevm/validator2/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="abfh"' > $HOME/.bfhevm/validator2/config/tmp_genesis.json && mv $HOME/.bfhevm/validator2/config/tmp_genesis.json $HOME/.bfhevm/validator2/config/genesis.json
cat $HOME/.bfhevm/validator2/config/genesis.json | jq '.app_state["cronos"]["params"]["ibc_cro_denom"]="ibc/7A1B557AE1BE5R82A1R3TYY44715G1G5241567GHT5H84814G845TR157SVA1759"' > $HOME/.bfhevm/validator2/config/tmp_genesis.json && mv $HOME/.bfhevm/validator2/config/tmp_genesis.json $HOME/.bfhevm/validator2/config/genesis.json
cat $HOME/.bfhevm/validator2/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="abfh"' > $HOME/.bfhevm/validator2/config/tmp_genesis.json && mv $HOME/.bfhevm/validator2/config/tmp_genesis.json $HOME/.bfhevm/validator2/config/genesis.json

# Set gas limit in genesis
cat $HOME/.bfhevm/validator2/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="20000000"' > $HOME/.bfhevm/validator2/config/tmp_genesis.json && mv $HOME/.bfhevm/validator2/config/tmp_genesis.json $HOME/.bfhevm/validator2/config/genesis.json

# Change parameter token denominations to abfh
perl -i -pe 's/^minimum-gas-prices = ".*?"/minimum-gas-prices = "0.01abfh"/' ~/.bfhevm/validator3/config/app.toml
cat $HOME/.bfhevm/validator3/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="abfh"' > $HOME/.bfhevm/validator3/config/tmp_genesis.json && mv $HOME/.bfhevm/validator3/config/tmp_genesis.json $HOME/.bfhevm/validator3/config/genesis.json
cat $HOME/.bfhevm/validator3/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="abfh"' > $HOME/.bfhevm/validator3/config/tmp_genesis.json && mv $HOME/.bfhevm/validator3/config/tmp_genesis.json $HOME/.bfhevm/validator3/config/genesis.json
cat $HOME/.bfhevm/validator3/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="abfh"' > $HOME/.bfhevm/validator3/config/tmp_genesis.json && mv $HOME/.bfhevm/validator3/config/tmp_genesis.json $HOME/.bfhevm/validator3/config/genesis.json
cat $HOME/.bfhevm/validator3/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="abfh"' > $HOME/.bfhevm/validator3/config/tmp_genesis.json && mv $HOME/.bfhevm/validator3/config/tmp_genesis.json $HOME/.bfhevm/validator3/config/genesis.json
cat $HOME/.bfhevm/validator3/config/genesis.json | jq '.app_state["cronos"]["params"]["ibc_cro_denom"]="ibc/7A1B557AE1BE5R82A1R3TYY44715G1G5241567GHT5H84814G845TR157SVA1759"' > $HOME/.bfhevm/validator3/config/tmp_genesis.json && mv $HOME/.bfhevm/validator3/config/tmp_genesis.json $HOME/.bfhevm/validator3/config/genesis.json
cat $HOME/.bfhevm/validator3/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="abfh"' > $HOME/.bfhevm/validator3/config/tmp_genesis.json && mv $HOME/.bfhevm/validator3/config/tmp_genesis.json $HOME/.bfhevm/validator3/config/genesis.json

# Set gas limit in genesis
cat $HOME/.bfhevm/validator3/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="20000000"' > $HOME/.bfhevm/validator3/config/tmp_genesis.json && mv $HOME/.bfhevm/validator3/config/tmp_genesis.json $HOME/.bfhevm/validator3/config/genesis.json

# Change parameter token denominations to abfh
perl -i -pe 's/^minimum-gas-prices = ".*?"/minimum-gas-prices = "0.01abfh"/' ~/.bfhevm/validator4/config/app.toml
cat $HOME/.bfhevm/validator4/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="abfh"' > $HOME/.bfhevm/validator4/config/tmp_genesis.json && mv $HOME/.bfhevm/validator4/config/tmp_genesis.json $HOME/.bfhevm/validator4/config/genesis.json
cat $HOME/.bfhevm/validator4/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="abfh"' > $HOME/.bfhevm/validator4/config/tmp_genesis.json && mv $HOME/.bfhevm/validator4/config/tmp_genesis.json $HOME/.bfhevm/validator4/config/genesis.json
cat $HOME/.bfhevm/validator4/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="abfh"' > $HOME/.bfhevm/validator4/config/tmp_genesis.json && mv $HOME/.bfhevm/validator4/config/tmp_genesis.json $HOME/.bfhevm/validator4/config/genesis.json
cat $HOME/.bfhevm/validator4/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="abfh"' > $HOME/.bfhevm/validator4/config/tmp_genesis.json && mv $HOME/.bfhevm/validator4/config/tmp_genesis.json $HOME/.bfhevm/validator4/config/genesis.json
cat $HOME/.bfhevm/validator4/config/genesis.json | jq '.app_state["cronos"]["params"]["ibc_cro_denom"]="ibc/7A1B557AE1BE5R82A1R3TYY44715G1G5241567GHT5H84814G845TR157SVA1759"' > $HOME/.bfhevm/validator4/config/tmp_genesis.json && mv $HOME/.bfhevm/validator4/config/tmp_genesis.json $HOME/.bfhevm/validator4/config/genesis.json
cat $HOME/.bfhevm/validator4/config/genesis.json | jq '.app_state["evm"]["params"]["evm_denom"]="abfh"' > $HOME/.bfhevm/validator4/config/tmp_genesis.json && mv $HOME/.bfhevm/validator4/config/tmp_genesis.json $HOME/.bfhevm/validator4/config/genesis.json

# Set gas limit in genesis
cat $HOME/.bfhevm/validator4/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="20000000"' > $HOME/.bfhevm/validator4/config/tmp_genesis.json && mv $HOME/.bfhevm/validator4/config/tmp_genesis.json $HOME/.bfhevm/validator4/config/genesis.json


# create validator node with tokens to transfer to the four other nodes
#bfhevmd add-genesis-account $(bfhevmd keys show validator1 -a --keyring-backend=test --home=$HOME/.bfhevmd/validator1) 100000000000abfh,10000000000000000000stake --home=$HOME/.bfhevmd/validator1
#bfhevmd gentx validator1 500000000abfh --keyring-backend=test --home=$HOME/.bfhevmd/validator1 --chain-id=testing
#bfhevmd collect-gentxs --home=$HOME/.bfhevmd/validator1

# Allocate genesis accounts (cosmos formatted addresses)
bfhevmd add-genesis-account $KEY1 100000000000000000000000000abfh,10000000000000000000stake --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator1

# Sign genesis transaction
bfhevmd gentx $KEY1 50000000000abfh --keyring-backend $KEYRING --chain-id $CHAINID --home=$HOME/.bfhevm/validator1

# Collect genesis tx
bfhevmd collect-gentxs --home=$HOME/.bfhevm/validator1

# Run this to ensure everything worked and that the genesis file is setup correctly
bfhevmd validate-genesis --home=$HOME/.bfhevm/validator1
################################################################################################################################################################

bfhevmd add-genesis-account $KEY2 100000000000000000000000000abfh,10000000000000000000stake --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator2

# Sign genesis transaction
bfhevmd gentx $KEY2 50000000000abfh --keyring-backend $KEYRING --chain-id $CHAINID --home=$HOME/.bfhevm/validator2

# Collect genesis tx
bfhevmd collect-gentxs --home=$HOME/.bfhevm/validator2

# Run this to ensure everything worked and that the genesis file is setup correctly
bfhevmd validate-genesis --home=$HOME/.bfhevm/validator2

####################################################################################################################################################################

bfhevmd add-genesis-account $KEY3 100000000000000000000000000abfh,10000000000000000000stake --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator3

# Sign genesis transaction
bfhevmd gentx $KEY3 50000000000abfh --keyring-backend $KEYRING --chain-id $CHAINID --home=$HOME/.bfhevm/validator3

# Collect genesis tx
bfhevmd collect-gentxs --home=$HOME/.bfhevm/validator3

# Run this to ensure everything worked and that the genesis file is setup correctly
bfhevmd validate-genesis --home=$HOME/.bfhevm/validator3

######################################################################################################################################################################

bfhevmd add-genesis-account $KEY4 100000000000000000000000000abfh,10000000000000000000stake --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator4

# Sign genesis transaction
bfhevmd gentx $KEY4 50000000000abfh --keyring-backend $KEYRING --chain-id $CHAINID --home=$HOME/.bfhevm/validator4

# Collect genesis tx
bfhevmd collect-gentxs --home=$HOME/.bfhevm/validator4

# Run this to ensure everything worked and that the genesis file is setup correctly
bfhevmd validate-genesis --home=$HOME/.bfhevm/validator4


# port key (validator1 uses default ports)
# validator1 1317, 9050, 9091, 8545, 8546, 8080, 26658, 26657, 26656, 6060, 26660
# validator2 1314, 9060, 9011, 8565, 8566, 8010, 26655, 26654, 26653, 6061, 26630
# validator3 1315, 9070, 9021, 8575, 8576, 8020, 26652, 26651, 26650, 6062, 26620
# validator4 1316, 9080, 9031, 8585, 8586, 8030, 26649, 26648, 26647, 6063, 26610


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.bfhevm/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.bfhevm/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.bfhevm/validator3/config/app.toml
VALIDATOR4_APP_TOML=$HOME/.bfhevm/validator4/config/app.toml

# validator1, need to change 9090 port as it conflicts with prometheus port
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9050|g' $VALIDATOR1_APP_TOML
#sed -i -E 's|0.0.0.0:8545|0.0.0.0:8545|g' $VALIDATOR1_APP_TOML
#sed -i -E 's|0.0.0.0:8546|0.0.0.0:8546|g' $VALIDATOR1_APP_TOML
#sed -i -E 's|0.0.0.0:9091|0.0.0.0:9091|g' $VALIDATOR1_APP_TOML
#sed -i -E 's|0.0.0.0:8080|0.0.0.0:8080|g' $VALIDATOR1_APP_TOML
#sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1317|g' $VALIDATOR1_APP_TOML

# validator2, need to change 9090 port as it conflicts with prometheus port
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9060|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:8545|0.0.0.0:8565|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:8546|0.0.0.0:8566|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9011|g' $VALIDATOR2_APP_TOML
sed -i -E 's|address = ":8080"|address = ":8010"|g' $VALIDATOR2_APP_TOML
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1314|g' $VALIDATOR2_APP_TOML

# validator3, need to change 9090 port as it conflicts with prometheus port
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9070|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:8545|0.0.0.0:8575|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:8546|0.0.0.0:8576|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9021|g' $VALIDATOR3_APP_TOML
sed -i -E 's|address = ":8080"|address = ":8020"|g' $VALIDATOR3_APP_TOML
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1315|g' $VALIDATOR3_APP_TOML

# validator4, need to change 9090 port as it conflicts with prometheus port
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9080|g' $VALIDATOR4_APP_TOML
sed -i -E 's|0.0.0.0:8545|0.0.0.0:8585|g' $VALIDATOR4_APP_TOML
sed -i -E 's|0.0.0.0:8546|0.0.0.0:8586|g' $VALIDATOR4_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9031|g' $VALIDATOR4_APP_TOML
sed -i -E 's|address = ":8080"|address = ":8030"|g' $VALIDATOR4_APP_TOML
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1316|g' $VALIDATOR4_APP_TOML


# change config.toml values
VALIDATOR1_CONFIG=$HOME/.bfhevm/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.bfhevm/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.bfhevm/validator3/config/config.toml
VALIDATOR4_CONFIG=$HOME/.bfhevm/validator4/config/config.toml

# validator1
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG
# sed -i -E 's|version = "v0"|version = "v1"|g' $VALIDATOR1_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR1_CONFIG

# validator2
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26628|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26627|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26626|g' $VALIDATOR2_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26610"|g' $VALIDATOR2_CONFIG

# validator3
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26638|g' $VALIDATOR3_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26637|g' $VALIDATOR3_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26636|g' $VALIDATOR3_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR3_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR3_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26620"|g' $VALIDATOR3_CONFIG

# validator4
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26648|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26647|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26646|g' $VALIDATOR4_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26630"|g' $VALIDATOR4_CONFIG


# disable produce empty block and enable prometheus metrics
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator1/config/config.toml
    sed -i '' 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator1/config/config.toml
    sed -i '' 's/prometheus-retention-time = 0/prometheus-retention-time  = 1000000000000/g' $HOME/.bfhevm/validator1/config/app.toml
    sed -i '' 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator1/config/app.toml
else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator1/config/config.toml
    sed -i 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator1/config/config.toml
    sed -i 's/prometheus-retention-time  = "0"/prometheus-retention-time  = "1000000000000"/g' $HOME/.bfhevm/validator1/config/app.toml
    sed -i 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator1/config/app.toml
fi

if [[ $1 == "pending" ]]; then
    echo "pending mode is on, please wait for the first block committed."
    if [[ $OSTYPE == "darwin"* ]]; then
        sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator1/config/config.toml
    else
        sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator1/config/config.toml
        sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator1/config/config.toml
    fi
fi

# disable produce empty block and enable prometheus metrics
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator2/config/config.toml
    sed -i '' 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator2/config/config.toml
    sed -i '' 's/prometheus-retention-time = 0/prometheus-retention-time  = 1000000000000/g' $HOME/.bfhevm/validator2/config/app.toml
    sed -i '' 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator2/config/app.toml
else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator2/config/config.toml
    sed -i 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator2/config/config.toml
    sed -i 's/prometheus-retention-time  = "0"/prometheus-retention-time  = "1000000000000"/g' $HOME/.bfhevm/validator2/config/app.toml
    sed -i 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator2/config/app.toml
fi

if [[ $1 == "pending" ]]; then
    echo "pending mode is on, please wait for the first block committed."
    if [[ $OSTYPE == "darwin"* ]]; then
        sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator2/config/config.toml
    else
        sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator2/config/config.toml
        sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator2/config/config.toml
    fi
fi

# disable produce empty block and enable prometheus metrics
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator3/config/config.toml
    sed -i '' 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator3/config/config.toml
    sed -i '' 's/prometheus-retention-time = 0/prometheus-retention-time  = 1000000000000/g' $HOME/.bfhevm/validator3/config/app.toml
    sed -i '' 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator3/config/app.toml
else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator3/config/config.toml
    sed -i 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator3/config/config.toml
    sed -i 's/prometheus-retention-time  = "0"/prometheus-retention-time  = "1000000000000"/g' $HOME/.bfhevm/validator3/config/app.toml
    sed -i 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator3/config/app.toml
fi

if [[ $1 == "pending" ]]; then
    echo "pending mode is on, please wait for the first block committed."
    if [[ $OSTYPE == "darwin"* ]]; then
        sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator3/config/config.toml
    else
        sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator3/config/config.toml
        sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator3/config/config.toml
    fi
fi

# disable produce empty block and enable prometheus metrics
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator4/config/config.toml
    sed -i '' 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator4/config/config.toml
    sed -i '' 's/prometheus-retention-time = 0/prometheus-retention-time  = 1000000000000/g' $HOME/.bfhevm/validator4/config/app.toml
    sed -i '' 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator4/config/app.toml
else
    sed -i 's/create_empty_blocks = true/create_empty_blocks = false/g' $HOME/.bfhevm/validator4/config/config.toml
    sed -i 's/prometheus = false/prometheus = true/' $HOME/.bfhevm/validator4/config/config.toml
    sed -i 's/prometheus-retention-time  = "0"/prometheus-retention-time  = "1000000000000"/g' $HOME/.bfhevm/validator4/config/app.toml
    sed -i 's/enabled = false/enabled = true/g' $HOME/.bfhevm/validator4/config/app.toml
fi

if [[ $1 == "pending" ]]; then
    echo "pending mode is on, please wait for the first block committed."
    if [[ $OSTYPE == "darwin"* ]]; then
        sed -i '' 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i '' 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator4/config/config.toml
    else
        sed -i 's/create_empty_blocks_interval = "0s"/create_empty_blocks_interval = "30s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_propose = "3s"/timeout_propose = "30s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_propose_delta = "500ms"/timeout_propose_delta = "5s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_prevote = "1s"/timeout_prevote = "10s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_prevote_delta = "500ms"/timeout_prevote_delta = "5s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_precommit = "1s"/timeout_precommit = "10s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_precommit_delta = "500ms"/timeout_precommit_delta = "5s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_commit = "5s"/timeout_commit = "150s"/g' $HOME/.bfhevm/validator4/config/config.toml
        sed -i 's/timeout_broadcast_tx_commit = "10s"/timeout_broadcast_tx_commit = "150s"/g' $HOME/.bfhevm/validator4/config/config.toml
    fi
fi



# copy validator1 genesis file to validator2-4
cp $HOME/.bfhevm/validator1/config/genesis.json $HOME/.bfhevm/validator2/config/genesis.json
cp $HOME/.bfhevm/validator1/config/genesis.json $HOME/.bfhevm/validator3/config/genesis.json
cp $HOME/.bfhevm/validator1/config/genesis.json $HOME/.bfhevm/validator4/config/genesis.json


# copy tendermint node id of validator1 to persistent peers of validator2-4
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$(bfhevmd tendermint show-node-id --home=$HOME/.bfhevm/validator1)@localhost:26656\"|g" $HOME/.bfhevm/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$(bfhevmd tendermint show-node-id --home=$HOME/.bfhevm/validator1)@localhost:26656\"|g" $HOME/.bfhevm/validator3/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$(bfhevmd tendermint show-node-id --home=$HOME/.bfhevm/validator1)@localhost:26656\"|g" $HOME/.bfhevm/validator4/config/config.toml

# start all four validators
tmux new -s validator1 -d bfhevmd start --home=$HOME/.bfhevm/validator1
tmux new -s validator2 -d bfhevmd start --home=$HOME/.bfhevm/validator2
tmux new -s validator3 -d bfhevmd start --home=$HOME/.bfhevm/validator3
tmux new -s validator4 -d bfhevmd start --home=$HOME/.bfhevm/validator4


# send abfh from first validator to second validator
echo "Waiting 7 seconds to send funds to validators 2, 3, and 4..."
sleep 7
bfhevmd tx bank send validator1 $(bfhevmd keys show $KEY2 -a --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator2) 500000000abfh,50000000000stake --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator1 --chain-id $CHAINID --broadcast-mode block --node http://localhost:26657 --yes --fees 1000000stake
bfhevmd tx bank send validator1 $(bfhevmd keys show $KEY3 -a --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator3) 400000000abfh,500000000stake --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator1 --chain-id $CHAINID --broadcast-mode block --node http://localhost:26657 --yes --fees 1000000stake
bfhevmd tx bank send validator1 $(bfhevmd keys show $KEY4 -a --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator4) 400000000abfh,500000000stake --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator1 --chain-id $CHAINID --broadcast-mode block --node http://localhost:26657 --yes --fees 1000000stake

# create second, third and fourth validator
bfhevmd tx staking create-validator --amount=500000000abfh --from=validator2 --pubkey=$(bfhevmd tendermint show-validator --home=$HOME/.bfhevm/validator2) --moniker $KEY2  --chain-id $CHAINID --commission-rate="0.1" --commission-max-rate="0.2" --commission-max-change-rate="0.05" --min-self-delegation="500000000" --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator2 --broadcast-mode block --node http://localhost:26657 --yes --fees 1000000stake
bfhevmd tx staking create-validator --amount=400000000abfh --from=validator3 --pubkey=$(bfhevmd tendermint show-validator --home=$HOME/.bfhevm/validator3) --moniker $KEY3 --chain-id $CHAINID --commission-rate="0.1" --commission-max-rate="0.2" --commission-max-change-rate="0.05" --min-self-delegation="400000000" --keyring-backend $KEYRING --home=$HOME/.bfhevm/validator3 --broadcast-mode block --node http://localhost:26657 --yes --fees 1000000stake
bfhevmd tx staking create-validator --amount=400000000abfh --from=validator4 --pubkey=$(bfhevmd tendermint show-validator --home=$HOME/.bfhevm/validator4) --moniker $KEY4 --chain-id $CHAINID --commission-rate="0.1" --commission-max-rate="0.2" --commission-max-change-rate="0.05" --min-self-delegation="400000000" --keyring-backend $KEYRING--home=$HOME/.bfhevm/validator4 --broadcast-mode block --node http://localhost:26657 --yes --fees 1000000stake

echo "All 4 Validators are up and running!"