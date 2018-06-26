#!/bin/bash

sudo cp -a /home/ubuntu/.ssh /root/
sudo chown -R root:root /root/.ssh
sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/bionic/devel ./ > /etc/apt/sources.list.d/py2deb.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 25508FAF711C1DEB
sudo apt-get update
sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y --force-yes \
                                        python-pip python-dev lintian liblapack-dev libblas-dev \
                                        dpkg-dev gfortran libfreetype6-dev libpng-dev pkg-config \
                                        python-setuptools python-py2deb libpq-dev libatlas-base-dev \
                                        libhdf5-dev \
                                        libexif-dev libjpeg-dev liblcms2-dev libtiff5-dev zlib1g-dev \
                                        freetds-dev libmysqlclient-dev pandoc swig
mkdir -p /home/ubuntu/py2deb
sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
