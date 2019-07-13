#!/bin/bash

REPO="https://github.com/ddboline/movie_collection_rust.git"

cd ~/

git clone $REPO movie_collection_rust

cd movie_collection_rust

make pull_xenial && make xenial && make package_xenial

cp movie-collection-rust*.deb ~/py2deb/
cp movie-collection-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/movie_collection_rust
