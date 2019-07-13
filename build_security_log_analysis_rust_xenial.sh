#!/bin/bash

REPO="https://github.com/ddboline/security_log_analysis_rust.git"

cd ~/

git clone $REPO security_log_analysis_rust

cd security_log_analysis_rust

make pull_xenial && make xenial && make package_xenial

cp security-log-analysis-rust*.deb ~/py2deb/
cp security-log-analysis-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/security_log_analysis_rust
