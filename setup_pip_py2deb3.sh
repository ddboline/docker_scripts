#!/bin/bash

sudo cp -a /home/ubuntu/.ssh /root/
sudo chown -R root:root /root/.ssh
sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/xenial/python3/devel ./ > /etc/apt/sources.list.d/py2deb.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 25508FAF711C1DEB
sudo apt-get update
sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y --force-yes \
                                        python3-pip python3-dev lintian liblapack-dev libblas-dev \
                                        dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                                        python3-setuptools python3-py2deb libpq-dev libatlas-base-dev
mkdir -p /home/ubuntu/py2deb3
sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
sudo rm -rf /usr/lib/python3/dist-packages/pkg_resources
