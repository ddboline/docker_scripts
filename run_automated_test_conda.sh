#!/bin/bash

SUDO=""
$SUDO echo ""
D=`date +%Y%m%d%H%M%S`

if [ -z $1 ]; then
    REPOS="aws_scripts blaze_test gapi_scripts garmin_app garmin_scripts
           programming_tests roku_app security_log_analysis sync_app"
else
    REPOS="$@"
fi

for REPO in $REPOS;
do
    $SUDO docker run --name=${REPO}_${D} -d ddboline/ddboline_keys:conda_latest /home/ubuntu/run_testing_conda.sh ${REPO}
done
