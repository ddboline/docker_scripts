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
    bottom,bottom,bottom
    broot,broot,broot
    cargo-bloat,cargo-bloat,cargo-bloat
    cargo-cache,cargo-cache,cargo-cache
    cargo-deb,cargo-deb,cargo-deb
    cargo-expand,cargo-expand,cargo-expand
    cargo-generate,cargo-generate,cargo-generate
    cargo-mutagen,cargo-mutagen,cargo-mutagen
    cargo-outdated,cargo-outdated,cargo-outdated
    cargo-scout,cargo-scout,cargo-scout
    cargo-sweep,cargo-sweep,cargo-sweep
    cargo-tarpaulin,cargo-tarpaulin,cargo-tarpaulin
    cargo-tree,cargo-tree,cargo-tree
    choose,choose,choose
    delta,delta,delta
    diesel_cli,diesel,diesel-cli
    dioxus-cli,dioxus,dioxus-cli
    dotenv-linter,dotenv-linter,dotenv-linter
    du-dust,dust,dust
    exa,exa,exa
    fastmod,fastmod,fastmod
    fd-find,fd,fd-find
    flamegraph,flamegraph,flamegraph
    frawk,frawk,frawk
    fselect,fselect,fselect
    fzf,fzf,fzf
    dog,dog,dog
    gping,gping,gping
    grex,grex,grex
    hexyl,hexyl,hexyl
    highlight-stderr,highlight-stderr,highlight-stderr
    hors,hors,hors
    ht,ht,ht
    huniq,huniq,huniq
    hx,hx,hx
    hyperfine,hyperfine,hyperfine
    jless,jless,jless
    jql,jql,jql
    kalker,kalker,kalker
    kdash,kdash,kdash
    kibi,kibi,kibi
    kiro-editor,kiro,kiro
    lfs,lfs,lfs
    lsd,lsd,lsd
    mcfly,mcfly,mcfly
    nu,nu,nu
    papyrus,papyrus,papyrus
    procs,procs,procs
    pwatch,pwatch,pwatch
    pyoxidizer,pyoxidizer,pyoxidizer
    refinery_cli,refinery,refinery-cli
    ripgrep,rg,ripgrep
    rust-script,rust-script,rust-script
    sd,sd,sd
    silicon,silicon,silicon
    sql_db_mapper,sql_db_mapper,sql-db-mapper
    starship,starship,starship
    tokei,tokei,tokei
    trunk,trunk,trunk
    waitfor,waitfor,waitfor
    watchexec,watchexec,watchexec
    weather_util_rust,weather-util-rust,weather-util-rust
    wool,wool,wool
    yj,yj,yj
    xh,xh,xh
    zoxide,zoxide,zoxide
"

if [ "$1" = "1" ]; then
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n20`
elif [ "$1" = "2" ]; then
    NPKGS=`echo $PKGS | sed 's: :\n:g' | wc -l`
    NPKGS=$((NPKGS-20))
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n40 | tail -n$NPKGS`
elif [ "$1" = "3" ]; then
    NPKGS=`echo $PKGS | sed 's: :\n:g' | wc -l`
    NPKGS=$((NPKGS-40))
    PKGS=`echo $PKGS | sed 's: :\n:g' | head -n60 | tail -n$NPKGS`
elif [ "$1" != "" ]; then
    PKGS=`echo $PKGS | sed 's: :\n:g' | grep $1`
fi

for PKG in $PKGS;
do
    CARGO=`echo $PKG | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKG | sed 's:,: :g' | awk '{print $2}'`;
    PACKAGE=`echo $PKG | sed 's:,: :g' | awk '{print $3}'`;
    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest /root/build_rust_pkg.sh ${CARGO} ${PACKAGE}
    sudo chown ${USER}:${USER} ~/py2deb3/*.deb
    scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
    rm ~/py2deb3/*.deb
done

if [ "$1" = "" -o "$1" = "2" ]; then
    `aws ecr --region us-east-1 get-login --no-include-email`
    docker pull ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest
    docker tag ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest rust_nightly:latest
    docker rmi ${AWS_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/rust_nightly:latest

    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_nightly:latest /root/build_rust_pkg.sh frawk frawk
    sudo chown ${USER}:${USER} ~/py2deb3/frawk_*.deb
    scp ~/py2deb3/frawk_*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
    rm ~/py2deb3/*.deb

    docker run --rm -v ~/py2deb3:/root/py2deb3 rust_stable:latest \
        /root/build_rust_pkg_repo.sh https://github.com/sanpii/explain.git explain
    sudo chown ${USER}:${USER} ~/py2deb3/explain_*.deb
    scp ~/py2deb3/explain_*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/devel_rust/
    rm ~/py2deb3/*.deb
fi

cd ~/
