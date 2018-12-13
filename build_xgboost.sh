#!/bin/bash

set -e

VERSION="0.60"
RELEASE="1"
REPO="https://github.com/ddboline/xgboost.git"

sudo apt-get update
sudo apt-get install -y checkinstall

cd ~/

git clone $REPO xgboost
cd xgboost

cd dmlc-core
git clone https://github.com/dmlc/dmlc-core .
make

cd ../rabit
git clone https://github.com/dmlc/rabit .
make

cd ../
printf "\ninstall:\n\tcp lib/libxgboost*.so /usr/lib/\n" >> Makefile
make
### this part is sadly interactive
printf "XGBoost: Fast Gradient Boosted Decision Trees\n" > description-pak
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} xgboost*.deb
mkdir -p ~/py2deb/
mv xgboost*.deb ~/py2deb/

sudo bash -c "echo deb [trusted=yes] https://py2deb-repo.s3.amazonaws.com/deb/bionic/python3 bionic main ./ > /etc/apt/sources.list.d/py2deb2.list"
sudo apt-get update
sudo apt-get install -y --force-yes python3-pip python3-dev lintian liblapack-dev libblas-dev \
                               dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                               python3-setuptools python3-py2deb python3-numpy=1.\* python3-scipy
mkdir -p /home/ubuntu/py2deb
cd python-package/
mkdir -p /home/ubuntu/py2deb3/py2deb3/

~/docker_scripts/build_python3_deb.sh .

cd ~/

rm -rf ~/xgboost
