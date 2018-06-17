#!/bin/bash

OPTS="--rename=pyyaml,python-yaml --rename=pyusb,python-usb --rename=websockify,websockify 
      --rename=scikit-learn,python-sklearn --rename=scikit-image,python-skimage 
      --rename=google-api-python-client,python-googleapi --rename=cython,cython
      --rename=pytz,python-tz --rename=pillow,python-pil
      --rename=beautifulsoup4,python-bs4 --rename=compose,python-docker-compose
      --rename=pyzmq,python-zmq --rename=spyder,spyder --rename=ipython,ipython
      --rename=pylint,pylint --rename=pyflakes,pyflakes --rename=python-dateutil,python-dateutil"

cd ~/docker_scripts/

git pull

cd ~/

mkdir -p /home/${USER}/py2deb

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-10 libhdf5-dev libxml2-dev libxslt1-dev \
                        libpython2.7-dev freetds-bin freetds-dev udev libgeos++-dev pandoc \
                        libfreetype6-dev libpng-dev libmysqlclient-dev swig

sudo apt-get install -y python-pip
sudo pip3 install git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1
sudo pip3 install git+https://github.com/ddboline/py2deb.git@1.1-1

py2deb -r /home/${USER}/py2deb -y $OPTS -- \
    --upgrade git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1 2>&1 >> build.log
py2deb -r /home/${USER}/py2deb -y $OPTS -- \
    --upgrade git+https://github.com/ddboline/py2deb.git@1.1-1 2>&1 >> build.log

scp /home/${USER}/py2deb/*.deb build.log \
    ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb/py2deb/
