#!/bin/bash

sudo bash -c "echo deb https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list"

sudo apt-get update
sudo apt-get install -y docker-engine
sudo usermod -aG docker ${USER}
sudo docker login -u ddboline -e ddboline@gmail.com
sudo docker pull ddboline/ddboline_keys:latest
