#!/bin/sh

CARGO_NAME=$1
VERSION=`cargo search $CARGO_NAME 2> /dev/null | head -n1 | awk '{print $3}' | sed 's:"::g'`
RELEASE="1"

echo $CARGO_NAME $VERSION $RELEASE

mkdir -p /${CARGO_NAME}
cd /${CARGO_NAME}

cargo install $CARGO_NAME --root=/${CARGO_NAME}
