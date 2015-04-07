#!/bin/bash

SUDO=""
$SUDO echo ""
$SUDO docker ps -a

CONTAINERS=`$SUDO docker ps -a | awk '!/CONTAIN/ {printf("%s,%s\n",$1,$NF)}'`
D=`date +%Y%m%d%H%M%S`

for CN in $CONTAINERS;
do
    C=`echo $CN | sed 's:,: :g' | awk '{print $1}'`
    N=`echo $CN | sed 's:,: :g' | awk '{print $2}'`
    mkdir temp_${N}_${D}_${C}
    $SUDO docker cp ${C}:/root/output.out temp_${N}_${D}_${C}/
    $SUDO docker cp ${C}:/root/output.err temp_${N}_${D}_${C}/
#     $SUDO docker cp ${C}:/root temp_${N}_${D}_${C}/
#     $SUDO docker cp ${C}:/root temp_${N}_${D}_${C}/
#     $SUDO docker cp ${C}:/root/garmin_app temp_${D}_${C}/
    $SUDO chown -R ${USER}:${USER} temp_${N}_${D}_${C}/
done
