#!/bin/bash

apt-get update
apt-get install -y python-pip
pip install py2deb
mkdir -p /root/py2deb
py2deb -r /root/py2deb -- --upgrade $@

scp /root/py2deb/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/
