#!/bin/bash

sudo apt-get update
sudo apt-get -o Dpkg::Options::="--force-overwrite" dist-upgrade -y
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev \
                        libxslt1-dev libpython2.7-dev freetds-bin freetds-dev \
                        udev libgeos++-dev

for PKG in `cat run_python_deb_pkgs.txt`;
do
    ./build_python_deb.sh $PKG
    sudo dpkg -i ~/py2deb/*.deb
    sudo apt-get install -f -y --force-yes
done
