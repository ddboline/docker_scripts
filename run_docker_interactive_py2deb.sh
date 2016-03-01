#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo "$@"
if [ -z $1 ]; then
    $SUDO docker run -it --name=\"bash_${D}\" --cidfile="$TMP" \
            ddboline/ddboline_keys:pip_py2deb_latest /bin/bash
    $SUDO docker ps -a
else
    REPO="$@"
    $SUDO docker run -it --name=\"${REPO}_${D}\" \
            --cidfile="$TMP" ddboline/ddboline_keys:pip_py2deb_latest /bin/bash \
                -c "/usr/bin/py2deb -r /home/ubuntu/py2deb -y -- --upgrade ${REPO} ; cd /home/ubuntu/ ; /bin/bash"
fi

### this has to be done by root...
sudo chown -R ${USER}:${USER} ~/setup_files/build/${REPO}/
sleep 5
$SUDO docker stop `cat $TMP`
sleep 5
$SUDO docker rm `cat $TMP`
$SUDO rm $TMP
