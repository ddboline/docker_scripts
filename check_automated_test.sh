#!/bin/bash

sudo echo ""
sudo docker ps -a

CONTAINERS=`sudo docker ps -a | awk '!/CONTAIN/ {print $1}'`

for C in $CONTAINERS;
do
    sudo docker logs $C 2>&1 | tail -n2
done

for C in $CONTAINERS;
do
    sudo docker top $C
done
