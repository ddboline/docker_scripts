#!/bin/bash

cp /etc/hosts temp.hosts
echo "10.124.15.33    GitLab02.visibleworld.com" >> temp.hosts
sudo mv temp.hosts /etc/hosts

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.3 npm
sudo ln -s /usr/bin/nodejs /usr/bin/node

git clone git@GitLab02.visibleworld.com:Data_Analytics/universe_api.git
sudo npm install -g grunt-cli


cd universe_api
npm install
grunt default
