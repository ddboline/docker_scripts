#!/bin/bash

REPO="https://github.com/ddboline/movie_collection_rust.git"

sudo apt-get update && \
sudo apt-get install -y curl pkg-config checkinstall gcc libssl-dev ca-certificates \
        file build-essential autoconf automake autotools-dev libtool xutils-dev \
        libusb-dev libxml2-dev libpq-dev && \
sudo rm -rf /var/lib/apt/lists/* && \
curl https://sh.rustup.rs > rustup.sh && \
sh rustup.sh -y && \
. ~/.cargo/env

cd ~/

git clone $REPO movie_collection_rust

cd movie_collection_rust

sh scripts/build_deb_docker.sh

cp movie-collection-rust*.deb ~/py2deb/
cp movie-collection-rust*.deb ~/py2deb3/

cd ~/

rm -rf ~/movie_collection_rust
