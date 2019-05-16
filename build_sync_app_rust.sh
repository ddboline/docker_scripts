#!/bin/bash

REPO="https://github.com/ddboline/sync_app_rust.git"

cd ~/

git clone $REPO sync_app_rust

cd sync_app_rust

make pull && make && make package

cp sync-app-rust*.deb ~/py2deb/
cp sync-app-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/sync_app_rust
