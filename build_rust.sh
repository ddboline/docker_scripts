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
    "b3sum,b3sum,b3sum" \
    "bandwhich,bandwhich,bandwhich" \
    "bat,bat,bat" \
    "bottom,bottom,bottom" \
    "cargo-edit,cargo-edit,cargo-edit" \
    "cargo-expand,cargo-expand,cargo-expand" \
    "cargo-generate,cargo-generate,cargo-generate" \
    "cargo-outdated,cargo-outdated,cargo-outdated" \
    "cargo-scout,cargo-scout,cargo-scout" \
    "cargo-tree,cargo-tree,cargo-tree" \
    "diesel_cli,diesel,diesel-cli" \
    "du-dust,dust,dust" \
    "exa,exa,exa" \
    "fd-find,fd,fd-find" \
    "highlight-stderr,highlight-stderr,highlight-stderr" \
    "hors,hors,hors" \
    "jql,jql,jql" \
    "pijul,pijul,pijul" \
    "ripgrep,rg,ripgrep" \
    "sql_db_mapper,sql_db_mapper,sql-db-mapper" \
    "tokei,tokei,tokei" \
    "weather_util_rust,weather-util-rust,weather-util-rust" \
    ;
do
    CARGO=`echo $PKGS | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKGS | sed 's:,: :g' | awk '{print $2}'`;
    PACKAGE=`echo $PKGS | sed 's:,: :g' | awk '{print $3}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest /root/build_rust_pkg.sh ${CARGO} ${EXE} ${PACKAGE}
    sudo chown ${USER}:${USER} ~/py2deb3/${PACKAGE}_*.deb
done

./docker_scripts/build_rust_pkg_repo.sh https://github.com/pop-os/debrepbuild.git debrepbuild debrep debrepbuild

cd ~/
