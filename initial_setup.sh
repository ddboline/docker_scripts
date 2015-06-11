#!/bin/bash
sudo apt-get install -y openssh-server
ssh-keygen -t rsa -b 4096

mkdir /home/ubuntu/.aws
scp ubuntu@ddbolineinthecloud.mooo.com:~/.aws/credentials /home/ubuntu/.aws/credentials
