# aura-node

## Build
    docker build . -t aura --build-arg VERSION=aura_v0.4.4
    
## Run 
    docker run -e NODE_MONIKER="MonPham" -v /mnt/blockstore/aura:/root/.aura --name aura -p 26656:26656 --restart unless-stopped -d aura

## Snapshot

    SNAP_NAME=$(curl -s https://snapshots1.nodejumper.io/aura/info.json | jq -r .fileName)
    axel -an 10 "https://snapshots1.nodejumper.io/aura/${SNAP_NAME}"
    lz4 -dc $SNAP_NAME | tar -xf - -C "$HOME/.aura"
