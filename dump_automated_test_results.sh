#!/bin/bash

sudo echo ""
sudo docker ps -a

CONTAINERS=`sudo docker ps -a | awk '!/CONTAIN/ {print $1}'`
