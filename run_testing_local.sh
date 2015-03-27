#!/bin/bash
REPONAME=$1
apt-get update
apt-get install -y git python-boto

export HOME="/root"
export USER="root"

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

SETUP_SCRIPT="setup_cloud9.sh"
TEST_SCRIPT="test_cloud9.sh"

cd ${HOME}/${REPONAME}
sh ${SETUP_SCRIPT}
sh ${TEST_SCRIPT}
