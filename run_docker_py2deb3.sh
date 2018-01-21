#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo "$@"
$SUDO docker run --rm -it --name=bash_${D} \
        ddboline/ddboline_keys:pip_py2deb3_latest /home/ubuntu/run_python3_deb_build.sh
