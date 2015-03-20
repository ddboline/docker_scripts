#!/bin/bash

REPOS="
blaze cvxopt nolearn numpy into odo pandas
scikit-learn scipy theano pystruct sqlalchemy
gensim nltk spacy scikit-monaco
pymc
seaborn
git+https://github.com/benanne/Lasagne.git
git+https://github.com/ddboline/pylearn2.git
"

apt-get update
apt-get install -y python-pip python-dev
pip install py2deb
mkdir -p /root/py2deb
for REPO in $REPOS;
do
    py2deb -r /root/py2deb -y -- --upgrade $REPO
done

# scp /root/py2deb/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/new/
