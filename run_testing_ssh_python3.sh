#!/bin/bash
sudo apt-get update
sudo apt-get install -y git

echo "Host *" >> ${HOME}/.ssh/config
echo "  StrictHostKeyChecking no" >> ${HOME}/.ssh/config

for REPONAME in $@;
do
    GITHUB_DIR=${REPONAME}
    GITHUB_REPO="ssh://ddboline@ddbolineathome.mooo.com/home/ddboline/setup_files/repo/${GITHUB_DIR}"
    SETUP_SCRIPT="setup_python3.sh"
    TEST_SCRIPT="test_python3.sh"
    
    git clone ${GITHUB_REPO} ${HOME}/${GITHUB_DIR}
    cd ${HOME}/${GITHUB_DIR}
    sh ${SETUP_SCRIPT}
    sh ${TEST_SCRIPT} $2 2> ${HOME}/output.err > ${HOME}/output.out
    cd ${HOME}
done