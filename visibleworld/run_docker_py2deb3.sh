#!/bin/bash

ECHO=""
SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
TMP="/tmp/tmp.docker.`head -c1000 /dev/urandom | tr -dc [:alpha:][:digit:] | head -c 12; echo ;`"
echo "$@"
$SUDO docker run --rm --name=bash_${D} \
        --dns="10.124.5.10" --dns="10.124.5.12" --dns-search="VisibleWorld.com" \
        -v /var/www/html/deb/xenial:/var/www/html/deb/xenial \
        danielb/danielb_keys:latest /home/ubuntu/docker_scripts/visibleworld/run_python3_deb_build.sh
