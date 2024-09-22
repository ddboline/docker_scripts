#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo snap install aws-cli --classic

mkdir -p ~/py2deb3/

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[",]::g')

./docker_scripts/build_rust_docker.sh 2>&1 > build_docker.log

scp build_docker.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/noble/devel_rust/
