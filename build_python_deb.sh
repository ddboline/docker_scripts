#!/bin/bash

# REPOS="
# numpy scipy pandas 
# blaze cvxopt scikit-learn
# into odo pymc seaborn
# nolearn theano pystruct sqlalchemy
# gensim nltk spacy scikit-monaco
# git+https://github.com/benanne/Lasagne.git
# git+https://github.com/ddboline/pylearn2.git
# "
REPOS="
blaze
"

apt-get update
apt-get install -y python-pip python-dev lintian liblapack-dev libblas-dev \
                   dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config
pip install py2deb
mkdir -p /root/py2deb
for REPO in $REPOS;
do
    py2deb -r /root/py2deb -y -- --upgrade $REPO
done

# scp /root/py2deb/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/new/
