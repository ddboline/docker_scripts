#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get \
    -o Dpkg::Options::=--force-confold \
    -o Dpkg::Options::=--force-confdef \
    -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    install -yq awscli

mkdir -p ~/py2deb3/

./docker_scripts/build_rust.sh 2>&1 > build_rust.log

MODIFIED=/home/${USER}/py2deb3/*.deb
if [ -n "$MODIFIED" ]; then
    scp $MODIFIED build_rust.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/bionic/devel_rust/
fi
