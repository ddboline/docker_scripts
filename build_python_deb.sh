#!/bin/bash

#py2deb -r /home/ubuntu/py2deb -y --rename=pyyaml,python-yaml --rename=pyusb,python-usb -- --upgrade pyyaml

OPTS="--rename=pyyaml,python-yaml --rename=pyusb,python-usb --rename=websockify,websockify 
      --rename=scikit-learn,python-sklearn --rename=scikit-image,python-skimage 
      --rename=google-api-python-client,python-googleapi --rename=cython,cython"

REPOS="py2deb youtube-dl py4j setuptools
       numpy scipy pandas scikit-learn scikit-image
       blaze gensim nltk statsmodels websockify sharedarray
       requests pysparkling cython pystan seaborn matplotlib
       theano lasagne nolearn scikit-neuralnetwork keras gdbn
       git+https://github.com/ddboline/pylearn2.git
       git+https://github.com/ddboline/garmin_app.git
       git+https://github.com/ddboline/roku_app.git
       git+https://github.com/ddboline/security_log_analysis.git
       git+https://github.com/ddboline/sync_app.git
       git+https://github.com/Tigge/openant.git
       git+https://github.com/Tigge/antfs-cli.git
       "

REPOS="$@"
if [ -z "$REPOS" ]; then
    REPOS=""
fi

if [ ! -e "/usr/bin/py2deb" ]; then
    sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/pip_py2deb ./ > /etc/apt/sources.list.d/py2deb2.list"
    sudo apt-get update
    sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libblas-dev \
                                dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                                python-setuptools python-py2deb
    mkdir -p /home/ubuntu/py2deb
fi

for REPO in $REPOS;
do
    py2deb -r /home/ubuntu/py2deb -y $OPTS -- --upgrade $REPO
done

ssh ddboline@ddbolineathome.mooo.com "mkdir -p /home/ddboline/setup_files/deb/py2deb/py2deb"
scp /home/ubuntu/py2deb/*.deb ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb/py2deb/
