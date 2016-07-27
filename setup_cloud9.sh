#!/bin/bash

sudo apt-get install -y docker-engine
sudo usermod -aG docker ${USER}
sudo docker login -u ddboline -e ddboline@gmail.com
sudo docker pull ddboline/ddboline_keys:latest
