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
    auth_server_rust,auth-server,rust
    aws_app_rust,aws-app-rust
    backup_app_rust,backup-app-rust
    calendar_app_rust,calendar-app-rust
    diary_app_rust,diary-app-rust
    garmin_rust,garmin-rust
    movie_collection_rust,movie-collection-rust
    notification_app_rust,notification-app-rust
    podcatch_rust,podcatch-rust
    security_log_analysis_rust,security-log-analysis-rust
    sync_app_rust,sync-app-rust
    weather_api_rust,weather-api-rust
"

PKGS=`echo $PKGS | sed 's: :\n:g'`

for PKG in $PKGS;
do
    CARGO=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    PACKAGE=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
        /root/build_rust_pkg_repo.sh https://github.com/ddboline/${CARGO}.git \
        ${CARGO} ${PACKAGE} main
    sudo chown ${USER}:${USER} ~/py2deb3/*.deb
    scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
    rm ~/py2deb3/*.deb
done
