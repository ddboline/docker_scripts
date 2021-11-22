#!/bin/sh

REPO_URL=$1
PACKAGE_NAME=$2

git clone $REPO_URL /workdir/$PACKAGE_NAME/

cd /workdir/$PACKAGE_NAME/
mkdir -p /${PACKAGE_NAME}

VERSION=`awk '/^version/' Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g'`
RELEASE="1"

echo $PACKAGE_NAME $VERSION $RELEASE

cargo install --path=. --root=/${PACKAGE_NAME}
