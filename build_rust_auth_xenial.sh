#!/bin/bash

REPO="https://github.com/ddboline/rust-auth-server.git"

cd ~/

git clone $REPO rust-auth-server

cd rust-auth-server

make pull_xenial && make xenial && make package_xenial

cp rust-auth*.deb ~/py2deb/
cp rust-auth*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/rust-auth-server
