#!/bin/bash

sudo apt-get install -y docker.io
sudo docker login -u ddboline -e ddboline@gmail.com
sudo docker pull ddboline/ddboline_keys:latest
