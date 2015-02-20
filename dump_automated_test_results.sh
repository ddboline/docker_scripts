#!/bin/bash

sudo echo ""
sudo docker ps -a

CONTAINERS=`sudo docker ps -a | awk '!/CONTAIN/ {printf("%s,%s\n", $1,$7}'`
D=`date +%Y%m%d%H%M%S`

for CN in $CONTAINERS;
do
    C=`echo $CN | sed 's:,: :g' | awk '{print $1}'`
    N=`echo $CN | sed 's:,: :g' | awk '{print $1}'`
    mkdir temp_${N}_${D}_${C}
    sudo docker cp ${C}:/root/output.out temp_${N}_${D}_${C}/
    sudo docker cp ${C}:/root/output.err temp_${N}_${D}_${C}/
    #sudo docker cp ${C}:/root/garmin_app temp_${D}_${C}/
    sudo chown -R ${USER}:${USER} temp_${N}_${D}_${C}/
done
