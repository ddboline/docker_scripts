#!/bin/bash

mkdir -p ~/py2deb3

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')

`aws ecr --region us-east-1 get-login --no-include-email`
docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest rust_nightly:latest
docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest

PKGS="
    frawk,frawk,frawk
"

if [ "$1" = "1" ]; then
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n20`
elif [ "$1" = "2" ]; then
    NPKGS=`echo $PKGS | sed 's: :\n:g' | wc -l`
    NPKGS=$((NPKGS-20))
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n40 | tail -n$NPKGS`
elif [ "$1" != "" ]; then
    PKGS=`echo $PKGS | sed 's: :\n:g' | grep $1`
fi

for PKG in $PKGS;
do
    CARGO=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKG | sed 's:,: :g' | awk '{print $2}'`;
    PACKAGE=`echo $PKG | sed 's:,: :g' | awk '{print $3}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_nightly:latest /root/build_rust_pkg.sh ${CARGO} ${EXE} ${PACKAGE}
    sudo chown ${USER}:${USER} ~/py2deb3/${PACKAGE}_*.deb
    scp ~/py2deb3/${PACKAGE}_*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/jammy/devel_rust/
done
