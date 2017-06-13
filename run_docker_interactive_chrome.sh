#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo $1
$SUDO docker run --rm -it --name=bash_${D} -m 1g \
        --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/ubuntu/.Xauthority \
        -e DISPLAY=$DISPLAY -v /dev/snd:/dev/snd --privileged \
        ddboline/ddboline_keys:chrome_test
$SUDO docker ps -a
