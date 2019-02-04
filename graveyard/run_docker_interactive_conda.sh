#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo $1
if [ -z $1 ]; then
    $SUDO docker run --rm -it --name=bash_${D} \
            ddboline/ddboline_keys:conda_latest /bin/bash
    $SUDO docker ps -a
else
    REPO=$1
    $SUDO docker run --rm -it --name=${REPO}_${D} \
            -v ~/setup_files/build/${REPO}:/home/ubuntu/${REPO} \
            ddboline/ddboline_keys:conda_latest /bin/bash \
                -c "sh /home/ubuntu/run_testing_local_conda.sh ${REPO} ; cd /home/ubuntu/${REPO} ; export HOME=/home/ubuntu ; export USER=ubuntu ; /bin/bash"
    ### this has to be done by root...
#     sudo chown -R ddboline:ddboline ~/setup_files/build/${REPO}/
fi
