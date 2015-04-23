#!/bin/bash

REPO="https://github.com/Grive/grive.git"

apt-get update
apt-get install -y libcurl3-dev libjson0-dev libjson-c-dev libjson-glib-dev \
                   libjsoncpp-dev libyajl-dev binutils-dev libboost-test-dev \
                   libboost-date-time1.54-dev libboost-filesystem1.54-dev \
                   libboost-program-options1.54-dev libboost-system1.54-dev \
                   libboost-thread1.54-dev cmake dpkg-dev libexpat1-dev libqt4-dev \
                   checkinstall

git clone $REPO

cd grive

cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .
make
### this part is sadly interactive
checkinstall
