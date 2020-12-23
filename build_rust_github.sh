#!/bin/bash

mkdir -p ~/py2deb3

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')

`aws ecr --region us-east-1 get-login --no-include-email`
docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest rust_stable:latest
docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

REPONAME=$1

REPO="https://github.com/ddboline/${REPONAME}.git"

cd ~/

git clone $REPO ${REPONAME}

cd ${REPONAME}

docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest /root/build_rust_pkg_deb.sh ${REPO} ${REPONAME}
sudo chown ${USER}:${USER} ~/py2deb3/*.deb

scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/

cd ~/

sudo rm -rf ~/${REPONAME}
