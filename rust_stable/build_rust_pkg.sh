#!/bin/bash

. ~/.cargo/env

CARGO_NAME=$1
PACKAGE_NAME=$2
VERSION=`cargo search $CARGO_NAME 2> /dev/null | head -n1 | awk '{print $3}' | sed 's:"::g'`
RELEASE="1"

echo $CARGO_NAME $PACKAGE_NAME $VERSION $RELEASE

mkdir -p /${CARGO_NAME}
cd /${CARGO_NAME}

cargo install $CARGO_NAME --root=/${CARGO_NAME}

printf "\ninstall:\n\tcp /${CARGO_NAME}/bin/* /usr/bin/\n" > Makefile
printf "${PACKAGE_NAME} package\n" > description-pak
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE_NAME} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb
mv ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb ~/py2deb3/
