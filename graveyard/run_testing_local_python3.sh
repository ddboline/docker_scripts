#!/bin/bash
sudo apt-get update
sudo apt-get install -y git

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

SETUP_SCRIPT="setup_python3.sh"
TEST_SCRIPT="test_python3.sh"

for REPONAME in $@;
do
    cd ${HOME}/${REPONAME}
    sh ${SETUP_SCRIPT}
    sh ${TEST_SCRIPT}
done
