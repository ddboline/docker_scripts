#!/bin/bash

mkdir -p ~/py2deb3

sudo apt-get update && \
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            curl pkg-config checkinstall gcc ca-certificates libssl-dev \
            file build-essential autoconf automake autotools-dev libtool xutils-dev \
            git libusb-dev libxml2-dev libpq-dev libpython3-dev llvm clang \
            default-libmysqlclient-dev libsqlite3-dev libsodium-dev libclang-dev \
            nettle-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev \
            libxcb-xfixes0-dev libpango1.0-dev libsoup2.4-dev libatk1.0-dev \
            libgdk-pixbuf2.0-dev libgdk3.0-cil-dev libgtk-3-dev \
            libappindicator3-dev libwebkit2gtk-4.1-dev && \
    sudo rm -rf /var/lib/apt/lists/* && \
    curl https://sh.rustup.rs > rustup.sh && \
    sh rustup.sh -y && \
    . ~/.cargo/env && \
    rustup component add rustfmt && \
    rustup component add clippy && \
    cargo install cargo-deb

REPONAME=$1

REPO="https://github.com/ddboline/${REPONAME}.git"

cd ~/

git clone $REPO ~/$REPONAME/

cd ~/$REPONAME/

VERSION=`awk '/^version/' Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g'`
RELEASE="1"

echo $CARGO_NAME $REPONAME $VERSION $RELEASE

cargo deb

mv ~/${REPONAME}/target/debian/*.deb ~/py2deb3/

sudo chown ${USER}:${USER} ~/py2deb3/*.deb

scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/noble/devel_rust/
rm ~/py2deb3/*.deb

rm -rf ~/${REPONAME}
