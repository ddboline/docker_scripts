#!/bin/bash

REPO_URL=$1
CRATE_NAME=$2
PACKAGE_NAME=$3
BRANCH_NAME=$4

echo $REPO_URL $CRATE_NAME $PACKAGE_NAME $BRANCH_NAME

mkdir -p ~/${CRATE_NAME}
cd ~/${CRATE_NAME}

printf "\ninstall:\n\tsource ${HOME}/.cargo/env && cargo install ${CRATE_NAME} --git=${REPO_URL} --branch=${BRANCH_NAME} --root=/usr\n" > Makefile
printf "${PACKAGE_NAME} package\n" > description-pak
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE_NAME} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb
mv ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb ~/py2deb3/
