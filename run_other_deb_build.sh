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

mkdir -p ~/py2deb/
mkdir -p ~/py2deb3/

./docker_scripts/build_fit2tcx.sh 2>&1 >> build.log
./docker_scripts/build_efs_utils.sh 2>&1 >> build.log
./docker_scripts/build_garmin_rust.sh 2>&1 >> build.log
./docker_scripts/build_movie_collection_rust.sh 2>&1 >> build.log
./docker_scripts/build_rust_auth.sh 2>&1 >> build.log
./docker_scripts/build_gcsf.sh 2>&1 >> build.log
./docker_scripts/build_sync_app_rust.sh 2>&1 >> build.log
./docker_scripts/build_podcatch_rust.sh 2>&1 >> build.log
./docker_scripts/build_security_log_analysis_rust.sh 2>&1 >> build.log

MODIFIED=/home/${USER}/py2deb3/*.deb
if [ -n "$MODIFIED" ]; then
    scp $MODIFIED build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb/bionic/py2deb/
    scp $MODIFIED build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/bionic/py2deb3/
fi
