#!/bin/bash
REPONAME=$1
sudo apt-get update
sudo apt-get install -y git

# export HOME="/root"
# export USER="root"

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

SETUP_SCRIPT="setup_cloud9.sh"
TEST_SCRIPT="test_cloud9.sh"

cd ${HOME}/${REPONAME}
sh ${SETUP_SCRIPT}
sh ${TEST_SCRIPT}
