#!/bin/bash

SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`
for REPO in ddboline_personal_scripts blaze_test;
do
    $SUDO docker run --name=\"${REPO}_${D}\" -d ddboline/ddboline_keys:latest /root/run_testing_ssh.sh ${REPO}
done
