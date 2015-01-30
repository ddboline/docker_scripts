#!/bin/bash
REPONAME=$1
apt-get update
apt-get install -y git python-boto

export HOME="/root"
export USER="root"

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

GITHUB_DIR=${REPONAME}
GITHUB_REPO="ssh://ubuntu@ddbolineinthecloud.mooo.com/home/ubuntu/setup_files/repo/ddboline_personal_scripts/${GITHUB_DIR}"
SETUP_SCRIPT="setup_cloud9.sh"
TEST_SCRIPT="test_cloud9.sh"

git clone ${GITHUB_REPO} ${HOME}/${GITHUB_DIR}
cd ${HOME}/${GITHUB_DIR}
sh ${SETUP_SCRIPT}
sh ${TEST_SCRIPT}
