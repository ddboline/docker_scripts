#!/bin/bash

VERSION="2.8"
RELEASE="1"

sudo apt-get update
sudo apt-get install -y subversion g++ make zlib1g-dev pkg-config \
                        checkinstall

svn co https://projects.coin-or.org/svn/Cbc/stable/2.8 coin_Cbc

cd coin_Cbc

./configure --enable-cbc-parallel --prefix=/usr
make
# printf "\ninstall:\n\tmv fit2tcx /usr/bin/\n" >> Makefile
printf "COIN-OR Linear Program Solver\n" > description-pak
### this part is sadly interactive
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} coin-cbc_${VERSION}-${RELEASE}*.deb
mv coin-cbc_${VERSION}-${RELEASE}*.deb ~/py2deb/
