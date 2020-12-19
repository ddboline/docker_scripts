#!/bin/bash

. ~/.cargo/env

REPO_URL=$1
PACKAGE_NAME=$2

git clone $REPO_URL $PACKAGE_NAME/

cd $PACKAGE_NAME/

VERSION=`awk '/^version/' Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g'`
RELEASE="1"

echo $CARGO_NAME $PACKAGE_NAME $VERSION $RELEASE

cargo +nightly build --release

printf "\ninstall:\n\tcp ~/${PACKAGE_NAME}/target/release/${EXE_NAME} /usr/bin/\n" > Makefile
printf "${PACKAGE_NAME} package\n" > description-pak
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE_NAME} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb
mv ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb ~/py2deb3/
