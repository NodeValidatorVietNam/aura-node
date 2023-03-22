#!/bin/bash
aurad version # main_v0.4.4-2-ga5d0798

aurad config chain-id xstaxy-1
aurad init "$NODE_MONIKER" --chain-id xstaxy-1

curl -s https://raw.githubusercontent.com/aura-nw/mainnet-artifacts/main/xstaxy-1/genesis.json > $HOME/.aura/config/genesis.json
curl -s https://snapshots1.nodejumper.io/aura/addrbook.json > $HOME/.aura/config/addrbook.json

SEEDS="22a0ca5f64187bb477be1d82166b1e9e184afe50@18.143.52.13:26656,0b8bd8c1b956b441f036e71df3a4d96e85f843b8@13.250.159.219:26656"
PEERS=""
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.aura/config/config.toml

sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.aura/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.aura/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.aura/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.aura/config/app.toml

sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001uaura"|g' $HOME/.aura/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.aura/config/config.toml

aurad tendermint unsafe-reset-all --home $HOME/.aura --keep-addr-book

$(which aurad) start
