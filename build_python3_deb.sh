#!/bin/bash

### hack...
export LANG="C.UTF-8"

sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/python3/pip_py2deb ./ > /etc/apt/sources.list.d/py2deb2.list"
sudo apt-get update

# REPOS="
# blaze numpy scipy pandas cvxopt scikit-learn into odo pymc seaborn 
# theano pystruct sqlalchemy gensim nltk spacy scikit-monaco
# git+https://github.com/dnouri/nolearn.git
# git+https://github.com/benanne/Lasagne.git
# git+https://github.com/ddboline/pylearn2.git
# git+https://github.com/fchollet/keras.git
# git+https://github.com/aigamedev/scikit-neuralnetwork.git
# "
REPOS="$@"

sudo apt-get update
sudo apt-get install -y python-pip python-py2deb python3-dev lintian liblapack-dev libblas-dev \
                   dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                   python3-pkg-resources python3-setuptools
mkdir -p /root/py2deb
for REPO in $REPOS;
do
    sudo py2deb -r /root/py2deb -y -- --upgrade $REPO
done

# scp /root/py2deb/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/new/
