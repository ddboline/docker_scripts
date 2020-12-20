#!/bin/bash

. ~/.cargo/env

REPO_URL=$1
PACKAGE_NAME=$2

git clone $REPO_URL /$PACKAGE_NAME/

cd /$PACKAGE_NAME/

VERSION=`awk '/^version/' Cargo.toml | head -n1 | cut -d "=" -f 2 | sed 's: ::g'`
RELEASE="1"

echo $CARGO_NAME $PACKAGE_NAME $VERSION $RELEASE

cargo deb

mv /${PACKAGE_NAME}/target/debian/*.deb ~/py2deb3/
