#!/bin/bash
sudo apt-get update
sudo apt-get install -y git

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

SETUP_SCRIPT="setup_cloud9.sh"
TEST_SCRIPT="test_cloud9.sh"

for REPONAME in $@;
do
    cd ${HOME}/${REPONAME}
    sh ${SETUP_SCRIPT}
    sh ${TEST_SCRIPT}
    cd ${HOME}
done
