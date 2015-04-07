#!/bin/bash

SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
for REPO in aws_scripts gapi_scripts garmin_app programming_tests;
do
    $SUDO docker run --name=\"${REPO}_${D}\" -d ddboline/ddboline_keys:latest /root/run_testing.sh ${REPO}
done
