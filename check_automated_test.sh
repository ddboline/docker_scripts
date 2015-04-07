#!/bin/bash

SUDO=""
$SUDO echo ""
$SUDO docker ps -a

CONTAINERS=`$SUDO docker ps -a | awk '!/CONTAIN/ {print $1}'`

for C in $CONTAINERS;
do
    $SUDO docker logs $C 2>&1 | tail -n2
done

for C in $CONTAINERS;
do
    $SUDO docker top $C
done
