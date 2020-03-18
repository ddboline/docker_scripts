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

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[",]::g')

./docker_scripts/build_rust_docker.sh 2>&1 > build_docker.log

scp build_docker.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/bionic/devel_rust/
