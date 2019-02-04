#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo "$@"
if [ -z $1 ]; then
    $SUDO docker run --rm -it --name=bash_${D} \
            ddboline/ddboline_keys:pip_py2deb_latest /bin/bash
    $SUDO docker ps -a
else
    REPO="$@"
    $SUDO docker run --rm -it --name=${REPO}_${D} \
            ddboline/ddboline_keys:pip_py2deb_latest /bin/bash \
                -c "/usr/bin/py2deb -r /home/ubuntu/py2deb -y -- --upgrade ${REPO} ; cd /home/ubuntu/ ; /bin/bash"
fi
