#!/bin/bash

SUDO=""
$SUDO echo ""
CONTAINERS=`$SUDO docker ps -a | awk '!/CONTAIN/ && $3 ~ /\/home\/ubuntu\/run_/ {print $1}'`

for C in $CONTAINERS;
do
    $SUDO docker rm $C
done
