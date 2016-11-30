#!/bin/bash

OPTS="--rename=pyyaml,python-yaml --rename=pyusb,python-usb --rename=websockify,websockify 
      --rename=scikit-learn,python-sklearn --rename=scikit-image,python-skimage 
      --rename=google-api-python-client,python-googleapi --rename=cython,cython
      --rename=pytz,python-tz --rename=pillow,python-pil
      --rename=beautifulsoup4,python-bs4 --rename=compose,python-docker-compose
      --rename=ipython,ipython --rename=pyzmq,python-zmq"

REPOS="py2deb youtube-dl py4j setuptools docker-compose
       numpy scipy pandas scikit-learn scikit-image
       blaze gensim nltk statsmodels websockify sharedarray
       requests pysparkling cython pystan seaborn matplotlib
       theano lasagne nolearn scikit-neuralnetwork keras gdbn
       "

REPOS="$@"
if [ -z "$REPOS" ]; then
    REPOS=""
fi

if [ ! -e "/usr/bin/py2deb" ]; then
    sudo bash -c "echo deb file:///var/www/html/deb/xenial/solver_python/ / > /etc/apt/sources.list.d/py2deb.list"
    sudo apt-get update
    sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libopenblas-dev \
                                dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                                python-setuptools python-py2deb
    mkdir -p /home/${USER}/py2deb
fi

for REPO in $REPOS;
do
    py2deb -r /home/${USER}/py2deb -y $OPTS -- $REPO
done
