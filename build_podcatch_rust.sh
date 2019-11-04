#!/bin/bash

REPO="https://github.com/ddboline/podcatch_rust.git"

cd ~/

git clone $REPO podcatch_rust

cd podcatch_rust

make pull && make && make package

mv podcatch-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/podcatch_rust
