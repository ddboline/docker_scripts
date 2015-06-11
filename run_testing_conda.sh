#!/bin/bash
REPONAME=$1
sudo apt-get update
sudo apt-get install -y git

# export HOME="/root"
# export USER="root"

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

GITHUB_DIR=${REPONAME}
GITHUB_REPO="https://github.com/ddboline/${GITHUB_DIR}.git"
SETUP_SCRIPT="setup_conda.sh"
TEST_SCRIPT="test_conda.sh"

git clone ${GITHUB_REPO} ${HOME}/${GITHUB_DIR}
cd ${HOME}/${GITHUB_DIR}
sh ${SETUP_SCRIPT}
sh ${TEST_SCRIPT} 2> ${HOME}/output.err > ${HOME}/output.out
