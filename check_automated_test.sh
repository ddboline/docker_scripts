#!/bin/bash

sudo echo ""
CONTAINERS=`sudo docker ps -a | awk '!/CONTAIN/ {print $1}'`

for C in $CONTAINERS;
do
    sudo docker logs $C 2>&1 | tail -n2
done
