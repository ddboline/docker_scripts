#!/bin/bash

REPO="https://github.com/ddboline/garmin_rust.git"

apt-get update && \
apt-get install -y curl pkg-config checkinstall gcc libssl-dev ca-certificates \
        file build-essential autoconf automake autotools-dev libtool xutils-dev \
        libusb-dev libxml2-dev libpq-dev && \
rm -rf /var/lib/apt/lists/* && \
curl https://sh.rustup.rs > rustup.sh && \
sh rustup.sh -y && \
. ~/.cargo/env

cd ~/

git clone $REPO garmin_rust

cd garmin_rust

sh scripts/build_deb_docker.sh

cp garmin-rust*.deb ~/py2deb/
cp garmin-rust*.deb ~/py2deb3/

cd ~/

rm -rf ~/garmin_rust
