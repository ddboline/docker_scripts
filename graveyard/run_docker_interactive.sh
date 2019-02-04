#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
UNIQ=`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`
TMP="/tmp/tmp.docker.${UNIQ}"
echo $1
if [ -z $1 ]; then
    $SUDO docker run --rm -it --name=bash_${D} \
            ddboline/ddboline_keys:latest /bin/bash
    $SUDO docker ps -a
else
    REPO=$1
    $SUDO docker run --rm -it --name=${REPO}_${D} \
            -v ~/setup_files/build/${REPO}:/home/ubuntu/${REPO} \
            ddboline/ddboline_keys:latest /bin/bash \
                -c "sh /home/ubuntu/run_testing_local.sh ${REPO} ; cd /home/ubuntu/${REPO} ; export HOME=/home/ubuntu ; export USER=ubuntu ; /bin/bash"
fi
