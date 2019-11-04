#!/bin/bash

REPO="https://github.com/ddboline/diary_app_rust.git"

cd ~/

git clone $REPO diary_app_rust

cd diary_app_rust

make pull && make && make package

mv diary-app-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/diary_app_rust
