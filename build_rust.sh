#!/bin/bash

mkdir -p ~/py2deb3

cd ~/docker_scripts/rust_nightly

make && make push

docker rmi -f `docker images | awk '/rust_nightly/ {print $3}' | sort | uniq`

cd ~/docker_scripts/rust_stable

make amazon && make push_amazon

docker rmi -f `docker images | awk '/rust_stable/ && /amazon/ {print $3}' | sort | uniq`

make && make push

for PKGS in "fd-find,fd,fd" \
    "exa,exa,exa" \
    "bat,bat,bat" \
    "du-dust,dust,du" \
    "diesel_cli,diesel,diesel-cli" \
    "cargo-generate,cargo-generate,cargo-generate" \
    "cargo-tree,cargo-tree,cargo-tree" \
    "cargo-outdated,cargo-outdated,cargo-outdated";
do
    CARGO=`echo $PKGS | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKGS | sed 's:,: :g' | awk '{print $2}'`;
    PACKAGE=`echo $PKGS | sed 's:,: :g' | awk '{print $3}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest /root/build_rust_pkg.sh ${CARGO} ${EXE} ${PACKAGE}
    sudo chown ${USER}:${USER} ~/py2deb3/${PACKAGE}_*.deb
done

cd ~/
