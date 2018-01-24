#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo "$@"
$SUDO docker run --rm --name=bash_${D} \
        danielb/danielb_keys:latest /home/ubuntu/docker_scripts/visibleworld/run_python3_deb_build.sh
