#!/bin/bash

. ~/.cargo/env

REPO_URL=$1
PACKAGE_NAME=$2

git clone $REPO_URL /workdir/$PACKAGE_NAME/

cd /workdir/$PACKAGE_NAME/
mkdir -p /${PACKAGE_NAME}

VERSION=`awk '/^version/' Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g'`
RELEASE="1"

echo $PACKAGE_NAME $VERSION $RELEASE

cargo install --path=. --root=/${PACKAGE_NAME}

printf "\ninstall:\n\tcp /${PACKAGE_NAME}/bin/* /usr/bin/\n" > Makefile
printf "${PACKAGE_NAME} package\n" > description-pak
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE_NAME} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_*.deb
mv ${PACKAGE_NAME}_*.deb ~/py2deb3/
