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

sudo apt-get update
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y \
        curl pkg-config checkinstall gcc libssl-dev ca-certificates \
        file build-essential autoconf automake autotools-dev libtool xutils-dev \
        git libusb-dev libxml2-dev libpq-dev libpython3.8-dev llvm clang \
        default-libmysqlclient-dev libsqlite3-dev libsodium-dev libclang-dev \
        nettle-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev \
        libxcb-xfixes0-dev
sudo rm -rf /var/lib/apt/lists/*
curl https://sh.rustup.rs > rustup.sh
sh rustup.sh -y
. ~/.cargo/env

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

PKGS=`echo $PKGS | sed 's: :\n:g' | grep $1`

for PKG in $PKGS;
do
    CARGO=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    PACKAGE=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    REPO_URL="https://github.com/ddboline/${CARGO}.git"

    printf "\ninstall:\n\t. ${HOME}/.cargo/env && cargo install ${CARGO} --git=${REPO_URL} --branch=main --root=/usr\n" > Makefile
    printf "${PACKAGE} package\n" > description-pak
    checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE} -y
    chown ${USER}:${USER} ${PACKAGE}_${VERSION}-${RELEASE}*.deb
    mv ${PACKAGE}_${VERSION}-${RELEASE}*.deb ~/py2deb3/

    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
        /root/build_rust_pkg_repo.sh https://github.com/ddboline/${CARGO}.git \
        ${CARGO} ${PACKAGE} main
    sudo chown ${USER}:${USER} ~/py2deb3/*.deb
    scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
    rm ~/py2deb3/*.deb
done
