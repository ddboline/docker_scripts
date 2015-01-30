#!/bin/bash

for REPO in aws_scripts gapi_scripts programming_tests;
do
    sudo docker run -d ddboline/ddboline_keys:v0.4 /root/run_testing.sh ${REPO}
done

sudo docker run -d ddboline/ddboline_keys:v0.4 /root/run_testing_ssh.sh ddboline_personal_scripts
