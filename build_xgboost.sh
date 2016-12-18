#!/bin/bash

set -e

VERSION="0.60"
RELEASE="1"
REPO="https://github.com/dmlc/xgboost.git"

sudo apt-get update
sudo apt-get install -y checkinstall

git clone $REPO
cd xgboost

cd dmlc-core
git clone https://github.com/dmlc/dmlc-core .
make

cd ../rabit
git clone https://github.com/dmlc/rabit .
make

cd ../
make
### this part is sadly interactive
printf "XGBoost: Fast Gradient Boosted Decision Trees\n" > description-pak
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} xgboost*.deb
mkdir -p ~/py2deb/
mv xgboost*.deb ~/py2deb/

sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/xenial/devel ./ > /etc/apt/sources.list.d/py2deb2.list"
sudo apt-get update
sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libblas-dev \
                               dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                               python-setuptools python-py2deb python-numpy=1.\* python-scipy
mkdir -p /home/ubuntu/py2deb
cd python-package/
if [ -e "/home/ubuntu/py2deb" ]; then
    ~/docker_scripts/build_python_deb.sh .
elif [ -e "/home/ubuntu/py2deb3" ]; then
    ~/docker_scripts/build_python3_deb.sh .
fi
