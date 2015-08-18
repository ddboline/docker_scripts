#!/bin/bash

REPO="https://github.com/ddboline/Fit2Tcx.git"

apt-get update
apt-get install -y libtinyxml-dev pkg-config \
                   checkinstall

git clone $REPO

cd Fit2Tcx

./configure --prefix=/usr
make
printf "\ninstall:\n\tmv fit2tcx /usr/bin/\n" >> Makefile
### this part is sadly interactive
checkinstall
