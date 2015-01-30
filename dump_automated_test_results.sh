#!/bin/bash

sudo echo ""
sudo docker ps -a

CONTAINERS=`sudo docker ps -a | awk '!/CONTAIN/ {print $1}'`

for C in $CONTAINERS;
do
    mkdir temp_$C
    sudo docker cp ${C}:/root/output.* temp_${C}/
    sudo chown -R ${USER}:${USER} temp_${C}/
done
