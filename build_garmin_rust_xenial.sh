#!/bin/bash

REPO="https://github.com/ddboline/garmin_rust.git"

cd ~/

git clone $REPO garmin_rust

cd garmin_rust

make pull_xenial && make xenial && make package_xenial

cp garmin-rust*.deb ~/py2deb/
cp garmin-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/garmin_rust
