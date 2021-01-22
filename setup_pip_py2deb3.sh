#!/bin/bash

sudo cp -a /home/ubuntu/.ssh /root/
sudo chown -R root:root /root/.ssh
sudo bash -c "echo deb [trusted=yes] https://py2deb-repo.s3.amazonaws.com/deb/focal/python3 focal main > /etc/apt/sources.list.d/py2deb3.list"
sudo apt-key adv --keyserver keyserver.ubuntu.com --receive-keys 25508FAF711C1DEB
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get \
    -o Dpkg::Options::=--force-confold \
    -o Dpkg::Options::=--force-confdef \
    -o Dpkg::Options::=--force-overwrite \
    -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    install -yq python3-pip python3-dev lintian liblapack-dev libblas-dev \
                dpkg-dev gfortran libfreetype6-dev libpng-dev pkg-config \
                libpq-dev libatlas-base-dev \
                libhdf5-dev libgeos-dev libgeos++-dev \
                libexif-dev libjpeg-dev liblcms2-dev libtiff5-dev zlib1g-dev \
                freetds-dev libmysqlclient-dev pandoc swig libsnappy-dev pybind11-dev \
                python3-apt apt-file fakeroot build-essential devscripts debhelper
sudo apt-file update
mkdir -p /home/ubuntu/py2deb3
mkdir -p /home/ubuntu/output
sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
