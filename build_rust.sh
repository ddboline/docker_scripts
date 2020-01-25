#!/bin/bash

mkdir -p ~/py2deb3

cd ~/docker_scripts/rust_nightly

make && make push

docker rmi -f `docker images | awk '/rust_nightly/ {print $3}' | sort | uniq`

cd ~/docker_scripts/rust_stable

make amazon && make push_amazon

docker rmi -f `docker images | awk '/rust_stable/ && /amazon/ {print $3}' | sort | uniq`

make && make push

for PKGS in \
    "bat,bat,bat" \
    "exa,exa,exa" \
    "fd-find,fd,fd-find" \
    "du-dust,dust,dust" \
    "ripgrep,rg,ripgrep" \
    "b3sum,b3sum,b3sum" \
    "weather_util_rust,weather-util-rust,weather-util-rust" \
    "diesel_cli,diesel,diesel-cli" \
    "sql_db_mapper,sql_db_mapper,sql-db-mapper" \
    "cargo-generate,cargo-generate,cargo-generate" \
    "cargo-tree,cargo-tree,cargo-tree" \
    "cargo-outdated,cargo-outdated,cargo-outdated" \
    "cargo-edit,cargo-edit,cargo-edit" \
    "cargo-scout,cargo-scout,cargo-scout" \
    "cargo-expand,cargo-expand,cargo-expand" \
    "bandwhich,bandwhich,bandwhich";
do
    CARGO=`echo $PKGS | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKGS | sed 's:,: :g' | awk '{print $2}'`;
    PACKAGE=`echo $PKGS | sed 's:,: :g' | awk '{print $3}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest /root/build_rust_pkg.sh ${CARGO} ${EXE} ${PACKAGE}
    sudo chown ${USER}:${USER} ~/py2deb3/${PACKAGE}_*.deb
done

./docker_scripts/build_rust_pkg_repo.sh https://github.com/pop-os/debrepbuild.git debrepbuild debrep debrepbuild

cd ~/
