#!/bin/bash

OPTS="--rename=pyyaml,python3-yaml --rename=pyusb,python3-usb"

REPOS="py2deb youtube-dl py4j setuptools sharedarray
       numpy scipy pandas scikit-learn
       blaze gensim nltk statsmodels
       requests pysparkling cython pystan seaborn matplotlib
       theano Lasagne nolearn scikit-neuralnetwork keras gdbn
       git+https://github.com/lisa-lab/pylearn2.git
       git+https://github.com/ddboline/garmin_app.git
       git+https://github.com/ddboline/roku_app.git
       git+https://github.com/ddboline/security_log_analysis.git
       git+https://github.com/ddboline/sync_app.git
       git+https://github.com/Tigge/antfs-cli.git
       git+https://github.com/Tigge/openant.git
       "

### hack...
export LANG="C.UTF-8"

sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/python3/pip_py2deb ./ > /etc/apt/sources.list.d/py2deb3.list"

REPOS="$@"

sudo apt-get update
sudo apt-get install -y --force-yes python3-pip python3-py2deb python3-dev lintian liblapack-dev libblas-dev \
                   dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                   python3-pkg-resources python3-setuptools
mkdir -p /home/ubuntu/py2deb3
for REPO in $REPOS;
do
    sudo py2deb -r /home/ubuntu/py2deb3 -y $OPTS --name-prefix=python3 -- --upgrade $REPO
done

ssh ddboline@ddbolineathome.mooo.com "rm /home/ddboline/setup_files/deb/py2deb3/py2deb3/*.deb"
scp /home/ubuntu/py2deb3/*.deb ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb3/py2deb3/
