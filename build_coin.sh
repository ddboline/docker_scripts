#!/bin/bash

VERSION="2.9.8"
RELEASE="1"

sudo apt-get update
sudo apt-get install -y git g++ make zlib1g-dev pkg-config \
                        checkinstall

git clone https://github.com/coin-or/Cbc coin_Cbc
cd coin_Cbc
git checkout releases/${VERSION}
git clone --branch=stable/0.8 https://github.com/coin-or-tools/BuildTools/
BuildTools/get.dependencies fetch

./configure --enable-cbc-parallel --prefix=/usr
make
# printf "\ninstall:\n\tmv fit2tcx /usr/bin/\n" >> Makefile
printf "COIN-OR Linear Program Solver\n" > description-pak
### this part is sadly interactive
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} coin-cbc_${VERSION}-${RELEASE}*.deb
mv coin-cbc_${VERSION}-${RELEASE}*.deb ~/py2deb/
