#!/bin/bash

sudo cp -a /home/ubuntu/.ssh /root/
sudo chown -R root:root /root/.ssh
sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/xenial/devel ./ > /etc/apt/sources.list.d/py2deb.list"
sudo apt-get update
sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libblas-dev \
                                        dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                                        python-setuptools python-py2deb
mkdir -p /home/ubuntu/py2deb
sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
