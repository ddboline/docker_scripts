#!/bin/bash

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

apt-get update
apt-get install -y python3-pip python3-dev lintian liblapack-dev libblas-dev \
                   dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config
rm /usr/bin/pip; ln -s /usr/bin/pip3 /usr/bin/pip # override python2 pip!!!
pip3 install py2deb
mkdir -p /root/py2deb
for REPO in $REPOS;
do
    py2deb -r /root/py2deb -y -- --upgrade $REPO
done

# scp /root/py2deb/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/new/
