FROM ubuntu:bionic
MAINTAINER Daniel Boline

RUN apt-get update && \
    apt-get install -y curl pkg-config checkinstall gcc libssl-dev ca-certificates \
            file build-essential autoconf automake autotools-dev libtool xutils-dev \
            git libusb-dev libxml2-dev libpq-dev && \
    rm -rf /var/lib/apt/lists/* && \
    curl https://sh.rustup.rs > rustup.sh && \
    sh rustup.sh -y && \
    . ~/.cargo/env

RUN . ~/.cargo/env && \
    rustup component add rustfmt && \
    rustup component add clippy

WORKDIR /workdir
