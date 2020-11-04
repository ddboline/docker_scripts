#!/bin/bash

REPO="https://github.com/ddboline/efs-utils.git"
TAG="v1.28.2-1"

sudo apt-get update
sudo apt-get install -y binutils pkg-config \
                        checkinstall rename

cd ~/

git clone -b $TAG $REPO efs-utils

cd efs-utils

make deb

mv build/amazon-efs-utils*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/efs-utils
