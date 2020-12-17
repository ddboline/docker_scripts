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

./docker_scripts/build_efs_utils.sh 2>&1 >> build.log

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')

`aws ecr --region us-east-1 get-login --no-include-email`
docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest rust_stable:latest
docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

PKGS="
    auth_server_rust
    aws_app_rust
    backup_app_rust
    calendar_app_rust
    diary_app_rust
    garmin_rust
    movie_collection_rust
    notification_app_rust
    podcatch_rust
    security_log_analysis_rust
    sync_app_rust
    weather_api_rust
"

for PKG in $PKGS;
do
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
        /root/build_rust_pkg_repo.sh https://github.com/ddboline/${PKG}.git ${PKG}
    sudo chown ${USER}:${USER} ~/py2deb3/*.deb
    scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
    rm ~/py2deb3/*.deb
done
