#!/bin/bash
sudo apt-get update
sudo apt-get install -y git

# export HOME="/root"
# export USER="root"

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

SETUP_SCRIPT="setup_conda.sh"
TEST_SCRIPT="test_conda.sh"

for REPONAME in $@;
do
    cd ${HOME}/${REPONAME}
    sh ${SETUP_SCRIPT}
    sh ${TEST_SCRIPT}
done
