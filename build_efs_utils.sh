#!/bin/bash

VERSION="0.4.3"
RELEASE="2"
REPO="https://github.com/aws/efs-utils.git"

sudo apt-get update
sudo apt-get install -y binutils pkg-config \
                        checkinstall

git clone $REPO

cd efs-utils

make deb

cp build/amazon-efs-utils*.deb ~/py2deb/
cp build/amazon-efs-utils*.deb ~/py2deb3/
