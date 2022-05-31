#!/bin/bash

mkdir -p ~/py2deb3 ~/bin

sudo apt-get update && \
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            curl pkg-config checkinstall gcc libssl-dev ca-certificates \
            file build-essential autoconf automake autotools-dev libtool xutils-dev \
            git libusb-dev libxml2-dev libpq-dev libpython3-dev llvm clang \
            default-libmysqlclient-dev libsqlite3-dev libsodium-dev libclang-dev \
            nettle-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev \
            libxcb-xfixes0-dev && \
    sudo rm -rf /var/lib/apt/lists/* && \
    curl https://sh.rustup.rs > rustup.sh && \
    sh rustup.sh -y && \
    . ~/.cargo/env && \
    rustup component add rustfmt && \
    rustup component add clippy && \
    cargo install cargo-deb

PKGS="
    b3sum,b3sum,b3sum
    bandwhich,bandwhich,bandwhich
    bat,bat,bat
    broot,broot,broot
    cargo-audit,cargo-audit,cargo-audit
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
    diesel_cli,diesel,diesel-cli
    dotenv-linter,dotenv-linter,dotenv-linter
    du-dust,dust,dust
    exa,exa,exa
    fastmod,fastmod,fastmod
    fd-find,fd,fd-find
    flamegraph,flamegraph,flamegraph
    frawk,frawk,frawk
    fselect,fselect,fselect
    grex,grex,grex
    highlight-stderr,highlight-stderr,highlight-stderr
    hors,hors,hors
    huniq,huniq,huniq
    hx,hx,hx
    hyperfine,hyperfine,hyperfine
    jql,jql,jql
    kibi,kibi,kibi
    kiro-editor,kiro,kiro
    lfs,lfs,lfs
    papyrus,papyrus,papyrus
    procs,procs,procs
    pyoxidizer,pyoxidizer,pyoxidizer
    refinery_cli,refinery,refinery-cli
    ripgrep,rg,ripgrep
    rust-script,rust-script,rust-script
    sd,sd,sd
    silicon,silicon,silicon
    sql_db_mapper,sql_db_mapper,sql-db-mapper
    starship,starship,starship
    tokei,tokei,tokei
    waitfor,waitfor,waitfor
    watchexec,watchexec,watchexec
    weather_util_rust,weather-util-rust,weather-util-rust
    wool,wool,wool
    yj,yj,yj
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
    VERSION=`cargo search $CARGO 2> /dev/null | head -n1 | awk '{print $3}' | sed 's:"::g'`
    RELEASE="1"

    if [ -z "$VERSION" ]; then
        continue;
    fi

    echo $CARGO $EXE $PACKAGE $VERSION $RELEASE

    cd ~/

    cargo install $CARGO --root=${HOME}

    printf "\ninstall:\n\tmv ${HOME}/bin/* /usr/bin/\n" > Makefile
    printf "${PACKAGE} package\n" > description-pak
    sudo checkinstall --pkgversion ${VERSION} --pkgrelease ${RELEASE} --pkgname ${PACKAGE} -y
    sudo chown ${USER}:${USER} ${PACKAGE}_*.deb
    mv ${PACKAGE}_*.deb ~/py2deb3/
    sudo chown ${USER}:${USER} ~/py2deb3/*.deb
    scp ~/py2deb3/*.deb ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/jammy/devel_rust/
    sudo rm ~/py2deb3/*.deb
done

cd ~/
