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

for PKGS in \
    "auth_server_rust,auth-server-rust" \
    "aws_app_rust,aws-app-rust" \
    "backup_app_rust,backup-app-rust" \
    "calendar_app_rust,calendar-app-rust" \
    "diary_app_rust,diary-app-rust" \
    "garmin_rust,garmin-rust" \
    "movie_collection_rust,movie-collection-rust" \
    "notification_app_rust,notification-app-rust" \
    "podcatch_rust,podcatch-rust" \
    "security_log_analysis_rust,security-log-analysis-rust" \
    "sync_app_rust,sync-app-rust" \
    "weather_api_rust,weather-api-rust,weather-api-rust";
do
    REPONAME=`echo $PKGS | sed 's:,: :g' | awk '{print $1}'`;
    PKGNAME=`echo $PKGS | sed 's:,: :g' | awk '{print $2}'`;

    ./docker_scripts/build_rust_github.sh $REPONAME $PKGNAME 2>&1 >> build.log
    scp ~/py2deb3/${PKGNAME}*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
done

scp build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
