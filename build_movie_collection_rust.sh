#!/bin/bash

REPO="https://github.com/ddboline/movie_collection_rust.git"

cd ~/

git clone $REPO movie_collection_rust

cd movie_collection_rust

make pull && make && make package

cp movie-collection-rust*.deb ~/py2deb/
cp movie-collection-rust*.deb ~/py2deb3/

cd ~/

rm -rf ~/movie_collection_rust
