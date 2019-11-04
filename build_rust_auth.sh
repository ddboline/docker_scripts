#!/bin/bash

REPO="https://github.com/ddboline/rust-auth-server.git"

cd ~/

git clone $REPO rust-auth-server

cd rust-auth-server

make pull && make && make package

mv rust-auth*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/rust-auth-server
