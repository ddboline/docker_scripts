#!/bin/bash

VERSION="0.4.3"
RELEASE="2"
REPO="https://github.com/aws/efs-utils.git"

sudo apt-get update
sudo apt-get install -y binutils pkg-config \
                        checkinstall rename

cd ~/

git clone $REPO efs-utils

cd efs-utils

make deb

rename 's:amazon-efs-utils-:amazon-efs-utils_:g' build/amazon-efs-utils-*.deb

cp build/amazon-efs-utils*.deb ~/py2deb/
cp build/amazon-efs-utils*.deb ~/py2deb3/

cd ~/

rm -rf ~/efs-utils
