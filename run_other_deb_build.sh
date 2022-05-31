#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get \
    -o Dpkg::Options::=--force-confold \
    -o Dpkg::Options::=--force-confdef \
    -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    install -yq awscli curl pkg-config checkinstall gcc libssl-dev ca-certificates \
                file build-essential autoconf automake autotools-dev libtool xutils-dev \
                git libusb-dev libxml2-dev libpq-dev libpython3-dev llvm clang \
                default-libmysqlclient-dev libsqlite3-dev libsodium-dev libclang-dev \
                nettle-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev \
                libxcb-xfixes0-dev nettle-dev && \
    sudo rm -rf /var/lib/apt/lists/* && \
    curl https://sh.rustup.rs > rustup.sh && \
    sh rustup.sh -y && \
    . ~/.cargo/env && \
    rustup component add rustfmt && \
    rustup component add clippy && \
    cargo install cargo-deb

mkdir -p ~/py2deb3/

cd ~/
git clone https://gitlab.com/sequoia-pgp/sequoia.git
cd ~/sequoia/

VERSION=`awk '/^version/' sq/Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g'`
RELEASE="1"

cargo build -p sequoia-sq --release

printf "\ninstall:\n\tcp ./target/release/sq /usr/bin/\n" > Makefile
printf "sequoia-sq package\n" > description-pak
sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname sequoia-sq -y
chown ${USER}:${USER} sequoia-sq_*.deb
mv sequoia-sq_*.deb ~/py2deb3/

scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/jammy/devel_rust/
rm ~/py2deb3/*.deb

rm -rf ~/sequoia

./docker_scripts/build_efs_utils.sh 2>&1 >> build.log

PKGS="
    auth_server_rust,auth-server-rust
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
    PACKAGE=`echo $PKG | sed 's:,: :g' | awk '{print $2}'`;
    REPO_URL="https://github.com/ddboline/${CARGO}.git"

    cd ~/
    git clone $REPO_URL

    cd ~/${CARGO}/

    VERSION=`awk '/^version/' Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g'`
    RELEASE="1"

    echo $CARGO_NAME $PACKAGE $VERSION $RELEASE

    cargo deb

    mv ~/${CARGO}/target/debian/*.deb ~/py2deb3/

    sudo chown ${USER}:${USER} ~/py2deb3/*.deb

    scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/jammy/devel_rust/
    rm ~/py2deb3/*.deb

    rm -rf ~/${CARGO}
done
