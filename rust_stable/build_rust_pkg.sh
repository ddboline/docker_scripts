#!/bin/bash

. ~/.cargo/env

CARGO_NAME=$1
EXE_NAME=$2
PACKAGE_NAME=$3
VERSION=`cargo search $CARGO_NAME 2> /dev/null | head -n1 | awk '{print $3}' | sed 's:"::g'`
RELEASE="1"

echo $CARGO_NAME $EXE_NAME $PACKAGE_NAME $VERSION $RELEASE

mkdir -p ~/${CARGO_NAME}
cd ~/${CARGO_NAME}

cargo install $CARGO_NAME

printf "\ninstall:\n\tcp ~/.cargo/bin/${EXE_NAME} /usr/bin/\n" > Makefile
printf "Convert fit files to tcx\n" > description-pak
### this part is sadly interactive
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb
mv ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb ~/py2deb3/
