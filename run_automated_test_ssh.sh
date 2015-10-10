#!/bin/bash

SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`

if [ -z $1 ]; then
    REPOS="ddboline_personal_scripts"
else
    REPOS="$@"
fi

for REPO in $REPOS; # theano_test;
do
    $SUDO docker run --name=\"${REPO}_${D}\" -d ddboline/ddboline_keys:latest /home/ubuntu/run_testing_ssh.sh ${REPO}
done
