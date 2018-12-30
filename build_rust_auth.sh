#!/bin/bash

VERSION="0.1.5"
RELEASE="1"
REPO="https://github.com/ddboline/rust-auth-server.git"

apt-get update && \
apt-get install -y curl pkg-config checkinstall gcc libssl-dev ca-certificates \
        file build-essential autoconf automake autotools-dev libtool xutils-dev \
        libusb-dev libxml2-dev libpq-dev && \
rm -rf /var/lib/apt/lists/* && \
curl https://sh.rustup.rs > rustup.sh && \
sh rustup.sh -y && \
. ~/.cargo/env

cd ~/

git clone $REPO rust-auth-server

cd rust-auth-server

sh scripts/build_deb_docker.sh

cp rust-auth*.deb ~/py2deb/
cp rust-auth*.deb ~/py2deb3/

cd ~/

rm -rf ~/rust-auth-server
