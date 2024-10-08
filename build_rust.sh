#!/bin/bash

mkdir -p ~/py2deb3

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')
export DOCKER_ENDPOINT=https://${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com

docker login -u AWS -p `aws ecr --region us-east-1 get-login-password` ${DOCKER_ENDPOINT}
docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest rust_stable:latest
docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

PKGS=`cat ./docker_scripts/rust_packages.txt`

if [ "$1" = "1" ]; then
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n20`
elif [ "$1" = "2" ]; then
    NPKGS=`echo $PKGS | sed 's: :\n:g' | wc -l`
    NPKGS=$((NPKGS-20))
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n40 | tail -n$NPKGS`
elif [ "$1" = "3" ]; then
    NPKGS=`echo $PKGS | sed 's: :\n:g' | wc -l`
    NPKGS=$((NPKGS-40))
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n60 | tail -n$NPKGS`
elif [ "$1" = "4" ]; then
    NPKGS=`echo $PKGS | sed 's: :\n:g' | wc -l`
    NPKGS=$((NPKGS-60))
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n80 | tail -n$NPKGS`
elif [ "$1" != "" ]; then
    PKGS=`echo $PKGS | sed 's: :\n:g' | grep $1`
fi

for PKG in $PKGS;
do
    CARGO=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKG | sed 's:,: :g' | awk '{print $2}'`;
    PACKAGE=`echo $PKG | sed 's:,: :g' | awk '{print $3}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest /root/build_rust_pkg.sh ${CARGO} ${PACKAGE}
    sudo chown ${USER}:${USER} ~/py2deb3/*.deb
    scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/noble/devel_rust/
    rm ~/py2deb3/*.deb
done

if [ "$1" = "" -o "$1" = "2" ]; then
    `aws ecr --region us-east-1 get-login --no-include-email`
    docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
    docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest rust_nightly:latest
    docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest

    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
        /root/build_rust_pkg_repo.sh https://github.com/sanpii/explain.git explain
    sudo chown ${USER}:${USER} ~/py2deb3/explain_*.deb
    scp ~/py2deb3/explain_*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/noble/devel_rust/
    rm ~/py2deb3/*.deb
fi

cd ~/
