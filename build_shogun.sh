#!/bin/bash

VERSION="4.0.1"
RELEASE="1"
REPO="https://github.com/shogun-toolbox/shogun.git"

sudo apt-get update
sudo apt-get install -y opencl-headers libprotobuf-dev \
                        ccache python-glpk python-cvxopt libglpk-dev \
                        libparpack2-dev libeigen3-dev libviennacl-dev \
                        liblpsolve55-dev lzma-dev libarchive-dev liblzo2-dev \
                        python-sip-dev swig cmake

cd ~/

git clone $REPO shogun

cd shogun

cmake -DCMAKE_INSTALL_PREFIX=/usr .
make
printf "SHOGUN machine learning toolbox\n" > description-pak
### this part is sadly interactive
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} shogun_${VERSION}-${RELEASE}*.deb
mv shogun_${VERSION}-${RELEASE}*.deb ~/py2deb/

cd ~/

rm -rf ~/shogun
