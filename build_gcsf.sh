#!/bin/bash

REPO="https://github.com/ddboline/gcsf.git"

cd ~/

git clone $REPO gcsf

cd gcsf

make pull && make && make package

cp gcsf*.deb ~/py2deb/
cp gcsf*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/gcsf
