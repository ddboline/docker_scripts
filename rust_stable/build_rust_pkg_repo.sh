#!/bin/bash

. ~/.cargo/env

REPO_URL=$1
CRATE_NAME=$2
PACKAGE_NAME=$3

echo $REPO_URL $CRATE_NAME $PACKAGE_NAME

printf "\ninstall:\n\tcargo install ${CRATE_NAME} --git ${REPO_URL} --root=/usr" > Makefile
printf "${PACKAGE_NAME} package\n" > description-pak
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE_NAME} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb
mv ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb ~/py2deb3/
