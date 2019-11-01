#!/bin/bash

PACKAGE_NAME=$1
EXE_NAME=$2
VERSION=`cargo search fd-find | head -n1 | awk '{print $3}' | sed 's:"::g'`
RELEASE="1"

echo $PACKAGE_NAME $EXE_NAME $VERSION $RELEASE

mkdir -p ~/${PACKAGE_NAME}
cd ~/${PACKAGE_NAME}

cargo install $PACKAGE_NAME

printf "\ninstall:\n\tcp ~/.cargo/bin/${EXE_NAME} /usr/bin/\n" > Makefile
printf "Convert fit files to tcx\n" > description-pak
### this part is sadly interactive
checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} -y
chown ${USER}:${USER} ${PACKAGE_NAME}_${VERSION}-${RELEASE}*.deb
