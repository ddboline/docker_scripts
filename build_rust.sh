#!/bin/bash

mkdir -p ~/py2deb3

export AWS_ACCOUNT=$(aws sts get-caller-identity | awk '/Account/ {print $2}' | sed 's:[^0-9]::g')

`aws ecr --region us-east-1 get-login --no-include-email`
docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest
docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest rust_stable:latest
docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_stable:latest

PKGS="
    b3sum,b3sum,b3sum
    bandwhich,bandwhich,bandwhich
    bat,bat,bat
    cargo-bloat,cargo-bloat,cargo-bloat
    cargo-deb,cargo-deb,cargo-deb
    cargo-expand,cargo-expand,cargo-expand
    cargo-generate,cargo-generate,cargo-generate
    cargo-mutagen,cargo-mutagen,cargo-mutagen
    cargo-outdated,cargo-outdated,cargo-outdated
    cargo-scout,cargo-scout,cargo-scout
    cargo-tarpaulin,cargo-tarpaulin,cargo-tarpaulin
    cargo-tree,cargo-tree,cargo-tree
    diesel_cli,diesel,diesel-cli
    du-dust,dust,dust
    exa,exa,exa
    fastmod,fastmod,fastmod
    fd-find,fd,fd-find
    flamegraph,flamegraph,flamegraph
    fselect,fselect,fselect
    grex,grex,grex
    highlight-stderr,highlight-stderr,highlight-stderr
    hors,hors,hors
    hx,hx,hx
    hyperfine,hyperfine,hyperfine
    jql,jql,jql
    kibi,kibi,kibi
    kiro-editor,kiro,kiro
    lfs,lfs,lfs
    procs,procs,procs
    pyoxidizer,pyoxidizer,pyoxidizer
    ripgrep,rg,ripgrep
    sd,sd,sd
    silicon,silicon,silicon
    sql_db_mapper,sql_db_mapper,sql-db-mapper
    starship,starship,starship
    tokei,tokei,tokei
    weather_util_rust,weather-util-rust,weather-util-rust
    watchexec,watchexec,watchexec
    wool,wool,wool
    yj,yj,yj
"

if [ "$1" != "" ]; then
    PKGS=`echo $PKGS | sed 's: :\n:g' | grep "$1"`
fi

for PKG in $PKGS;
do
    CARGO=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKG | sed 's:,: :g' | awk '{print $2}'`;
    PACKAGE=`echo $PKG | sed 's:,: :g' | awk '{print $3}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest /root/build_rust_pkg.sh ${CARGO} ${EXE} ${PACKAGE}
    sudo chown ${USER}:${USER} ~/py2deb3/${PACKAGE}_*.deb
    scp ~/py2deb3/${PACKAGE}_*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
done

if [ "$1" = "" ]; then
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
        /root/build_rust_pkg_repo.sh https://github.com/cjbassi/ytop ytop ytop
    sudo chown ${USER}:${USER} ~/py2deb3/ytop_*.deb

    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
        /root/build_rust_pkg_repo.sh https://github.com/sanpii/explain.git explain explain-rs
    sudo chown ${USER}:${USER} ~/py2deb3/explain_*.deb
fi

cd ~/
