#!/bin/bash

sudo echo ""
CONTAINERS=`sudo docker ps -a | awk '!/CONTAIN/ && $3 ~ /\/root\/run_testing/ {print $1}'`
