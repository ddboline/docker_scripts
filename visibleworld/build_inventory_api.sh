#!/bin/bash

cp /etc/hosts temp.hosts
echo "10.124.15.33    GitLab02.visibleworld.com" >> temp.hosts
sudo cp temp.hosts /etc/hosts

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.3 npm
sudo ln -s /usr/bin/nodejs /usr/bin/node

cd ~/
mkdir ~/tmp

git clone /home/ddboline/setup_files/build/inventory_api
sudo npm install -g grunt-cli

cd inventory_api
npm install
grunt default
