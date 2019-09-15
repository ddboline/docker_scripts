#!/bin/bash

REPO="https://github.com/ddboline/diary_app_rust.git"

cd ~/

git clone $REPO diary_app_rust

cd diary_app_rust

make pull_xenial && make xenial && make package_xenial

cp diary-app-rust*.deb ~/py2deb/
cp diary-app-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/diary_app_rust
