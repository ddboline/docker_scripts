#!/bin/bash

sudo echo ""
sudo docker ps -a

CONTAINERS=`sudo docker ps -a | awk '!/CONTAIN/ {print $1}'`
D=`date +%Y%m%d%H%M%S`

for C in $CONTAINERS;
do
    mkdir temp_${D}_${C}
    sudo docker cp ${C}:/root/output.out temp_${D}_${C}/
    sudo docker cp ${C}:/root/output.err temp_${D}_${C}/
    sudo chown -R ${USER}:${USER} temp_${D}_${C}/
done
