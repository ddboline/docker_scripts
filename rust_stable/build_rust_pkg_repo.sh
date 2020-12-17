#!/bin/bash

. ~/.cargo/env

REPO_URL=$1
PACKAGE_NAME=$2

echo $REPO_URL $PACKAGE_NAME

printf "\ninstall:\n\tcargo install ${PACKAGE_NAME} --git ${REPO_URL} --root=/usr" > Makefile
printf "${PACKAGE_NAME} package\n" > description-pak
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE_NAME} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb
mv ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb ~/py2deb3/
