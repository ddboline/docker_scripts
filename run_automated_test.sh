#!/bin/bash

sudo echo ""
D=`date +%Y%m%d%H%M%S`
for REPO in aws_scripts gapi_scripts garmin_app programming_tests;
do
    sudo docker run -d ddboline/ddboline_keys:v0.4 --name="${REPO}_${D}" /root/run_testing.sh ${REPO}
done

sudo docker run -d ddboline/ddboline_keys:v0.4 --name="ddboline_personal_scripts_${D}" /root/run_testing_ssh.sh ddboline_personal_scripts
