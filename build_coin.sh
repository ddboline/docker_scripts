#!/bin/bash

VERSION="2.9"
RELEASE="1"

sudo apt-get update
sudo apt-get install -y git g++ make zlib1g-dev pkg-config \
                        checkinstall

git clone https://github.com/coin-or/Cbc.git coin_Cbc

cd coin_Cbc

git checkout releases/2.9.9

./configure --enable-cbc-parallel=yes --prefix=/usr
make
# printf "\ninstall:\n\tmv fit2tcx /usr/bin/\n" >> Makefile
printf "COIN-OR Linear Program Solver\n" > description-pak
### this part is sadly interactive
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} coin-cbc_${VERSION}-${RELEASE}*.deb
cp coin-cbc_${VERSION}-${RELEASE}*.deb ~/py2deb/
cp coin-cbc_${VERSION}-${RELEASE}*.deb ~/py2deb3/
