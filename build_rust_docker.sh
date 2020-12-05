#!/bin/bash

mkdir -p ~/py2deb3

cd ~/docker_scripts/rust_nightly

(make && make push) || (make pull && make update && make push)

docker rmi -f `docker images | awk '/rust_nightly/ {print $3}' | sort | uniq`

cd ~/docker_scripts/rust_stable

make amazon && make push_amazon

docker rmi -f `docker images | awk '/rust_stable/ && /amazon/ {print $3}' | sort | uniq`

make && make push
