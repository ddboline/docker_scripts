#!/bin/bash

REPO="https://github.com/ddboline/security_log_analysis_rust.git"

cd ~/

git clone $REPO security_log_analysis_rust

cd security_log_analysis_rust

make pull && make && make package

mv security-log-analysis-rust*.deb ~/py2deb3/

cd ~/

sudo rm -rf ~/security_log_analysis_rust
