#!/bin/bash

OPTS="--rename=pyyaml,python3-yaml --rename=pyusb,python3-usb --rename=websockify,websockify3 
      --rename=scikit-learn,python3-sklearn --rename=scikit-image,python3-skimage 
      --rename=google-api-python-client,python3-googleapi --rename=cython,cython3
      --rename=pytz,python3-tz --rename=pillow,python3-pil --rename=python-debian,python3-debian
      --rename=beautifulsoup4,python3-bs4 --rename=compose,python3-docker-compose
      --rename=pyzmq,python3-zmq --rename=spyder,spyder3 --rename=ipython,ipython3
      --rename=pylint,pylint3 --rename=pyflakes,pyflakes3 --rename=python-dateutil,python3-dateutil"

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
    sudo bash -c "echo deb file:///var/www/html/deb/xenial/python3/devel/ / > /etc/apt/sources.list.d/py2deb3.list"
    sudo apt-get update
    sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y --force-yes \
                                python3-pip python3-py2deb python3-dev lintian liblapack-dev libblas-dev \
                                dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                                python3-setuptools
    mkdir -p /home/${USER}/py2deb3
fi

for REPO in $REPOS;
do
    py2deb -r /home/${USER}/py2deb3 -y $OPTS --name-prefix=python3 -- --upgrade $REPO
done
