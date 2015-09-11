#!/bin/bash

# REPOS=git+https://github.com/Lasagne/Lasagne.git \
#       git+https://github.com/dnouri/nolearn.git
#       git+https://github.com/lisa-lab/pylearn2.git
#       

REPOS="$@"

sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/pip_py2deb ./ > /etc/apt/sources.list.d/py2deb2.list"
sudo apt-get update
sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libblas-dev \
                               dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                               python-setuptools python-py2deb
# pip install py2deb
mkdir -p /home/ubuntu/py2deb
for REPO in $REPOS;
do
    py2deb -r /home/ubuntu/py2deb -y -- $REPO
done
