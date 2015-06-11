#!/bin/bash

ECHO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo $1
$SUDO docker run -it --name=\"bash_${D}\" --cidfile="$TMP" -m 1g \
        --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/ubuntu/.Xauthority \
        -e DISPLAY=$DISPLAY -v /dev/snd:/dev/snd --privileged \
        ddboline/ddboline_keys:spyder_test
$SUDO docker ps -a

### this has to be done by root...
# sudo chown -R ddboline:ddboline ~/setup_files/build/${REPO}/
sleep 5
$SUDO docker stop `cat $TMP`
sleep 5
$SUDO docker rm `cat $TMP`
$SUDO rm $TMP
