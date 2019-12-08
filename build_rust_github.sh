#!/bin/bash

REPONAME=$1
PKGNAME=$2

REPO="https://github.com/ddboline/${REPONAME}.git"

cd ~/

git clone $REPO ${REPONAME}

cd ${REPONAME}

make pull && make && make package

mv ${PKGNAME}*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/${REPONAME}
