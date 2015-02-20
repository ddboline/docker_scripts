#!/bin/bash

sudo echo ""
D=`date +%Y%m%d%H%M%S`
for REPO in aws_scripts gapi_scripts garmin_app programming_tests;
do
    sudo docker run --name=\"${REPO}_${D}\" -d ddboline/ddboline_keys:v0.4 /root/run_testing.sh ${REPO}
done

sudo docker run --name=\"ddboline_personal_scripts_${D}\" -d ddboline/ddboline_keys:v0.4 /root/run_testing_ssh.sh ddboline_personal_scripts
