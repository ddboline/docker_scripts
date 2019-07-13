#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y awscli

mkdir -p ~/py2deb/
mkdir -p ~/py2deb3/

./docker_scripts/build_fit2tcx.sh 2>&1 >> build.log
./docker_scripts/build_efs_utils.sh 2>&1 >> build.log
./docker_scripts/build_garmin_rust_xenial.sh 2>&1 >> build.log
./docker_scripts/build_movie_collection_rust_xenial.sh 2>&1 >> build.log
./docker_scripts/build_rust_auth_xenial.sh 2>&1 >> build.log
./docker_scripts/build_sync_app_rust_xenial.sh 2>&1 >> build.log
./docker_scripts/build_podcatch_rust_xenial.sh 2>&1 >> build.log
./docker_scripts/build_security_log_analysis_rust_xenial.sh 2>&1 >> build.log

MODIFIED=/home/${USER}/py2deb3/*.deb
if [ -n "$MODIFIED" ]; then
    scp $MODIFIED build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb/xenial/py2deb/
    scp $MODIFIED build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/xenial/py2deb3/
fi
