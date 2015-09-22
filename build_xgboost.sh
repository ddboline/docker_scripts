#!/bin/bash

VERSION="0.4.3"
RELEASE="2"
REPO="https://github.com/ddboline/xgboost.git"

sudo apt-get update
sudo apt-get install -y checkinstall

git clone $REPO

cd xgboost

make
### this part is sadly interactive
printf "XGBoost: Fast Gradient Boosted Decision Trees\n" > description-pak
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
sudo chown ${USER}:${USER} fit2tcx_${VERSION}-${RELEASE}*.deb

sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/pip_py2deb ./ > /etc/apt/sources.list.d/py2deb2.list"
sudo apt-get update
sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libblas-dev \
                               dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                               python-setuptools python-py2deb python-numpy python-scipy
mkdir -p /home/ubuntu/py2deb
cd python-package/
py2deb -r /home/ubuntu/py2deb -y -- .
