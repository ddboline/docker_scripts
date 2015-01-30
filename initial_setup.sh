#!/bin/bash
apt-get install -y openssh-server
ssh-keygen -t rsa -b 4096

mkdir /root/.aws
scp ubuntu@ddbolineinthecloud.mooo.com:~/.aws/credentials /root/.aws/credentials
