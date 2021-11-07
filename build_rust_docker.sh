#!/bin/bash

mkdir -p ~/py2deb3

cd ~/docker_scripts/rust_nightly

(make && make push) || (make pull && make update && make push)

docker rmi -f `docker images | awk '/rust_nightly/ {print $3}' | sort | uniq`

cd ~/docker_scripts/rust_stable

make && make push
