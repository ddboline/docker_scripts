#!/bin/bash

mkdir -p ~/py2deb3

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')

`aws ecr --region us-east-1 get-login --no-include-email`
docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest rust_stable:latest
docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

for PKGS in \
    "b3sum,b3sum,b3sum" \
    "bandwhich,bandwhich,bandwhich" \
    "bat,bat,bat" \
    "bottom,bottom,bottom" \
    "cargo-expand,cargo-expand,cargo-expand" \
    "cargo-generate,cargo-generate,cargo-generate" \
    "cargo-outdated,cargo-outdated,cargo-outdated" \
    "cargo-scout,cargo-scout,cargo-scout" \
    "cargo-tree,cargo-tree,cargo-tree" \
    "diesel_cli,diesel,diesel-cli" \
    "du-dust,dust,dust" \
    "exa,exa,exa" \
    "fd-find,fd,fd-find" \
    "flamegraph,flamegraph,flamegraph" \
    "highlight-stderr,highlight-stderr,highlight-stderr" \
    "hors,hors,hors" \
    "hx,hx,hx" \
    "hyperfine,hyperfine,hyperfine" \
    "jql,jql,jql" \
    "kibi,kibi,kibi" \
    "pijul,pijul,pijul" \
    "procs,procs,procs" \
    "pyoxidizer,pyoxidizer,pyoxidizer" \
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

docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
    /root/build_rust_pkg_repo.sh https://github.com/cjbassi/ytop ytop ytop

docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
    /root/build_rust_pkg_repo.sh https://github.com/sanpii/explain.git explain explain-rs

cd ~/
