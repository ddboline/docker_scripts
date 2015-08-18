#!/bin/bash

### hack...
export LANG="C.UTF-8"

sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/python3/pip_py2deb ./ > /etc/apt/sources.list.d/py2deb2.list"

REPOS="$@"

sudo apt-get update
sudo apt-get install -y --force-yes python3-pip python3-py2deb python3-dev lintian liblapack-dev libblas-dev \
                   dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                   python3-pkg-resources python3-setuptools
mkdir -p /home/ubuntu/py2deb3
for REPO in $REPOS;
do
    sudo py2deb -r /home/ubuntu/py2deb3 -y --name-prefix=python3 -- $REPO
done

# scp /root/py2deb/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/new/
