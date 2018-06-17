#!/bin/bash

OPTS="--rename=pyyaml,python3-yaml --rename=pyusb,python3-usb --rename=websockify,websockify3 
      --rename=scikit-learn,python3-sklearn --rename=scikit-image,python3-skimage 
      --rename=google-api-python-client,python3-googleapi --rename=cython,cython3
      --rename=pytz,python3-tz --rename=pillow,python3-pil --rename=python-debian,python3-debian
      --rename=beautifulsoup4,python3-bs4 --rename=compose,python3-docker-compose
      --rename=pyzmq,python3-zmq --rename=spyder,spyder3 --rename=ipython,ipython3
      --rename=pylint,pylint3 --rename=pyflakes,pyflakes3 --rename=python-dateutil,python3-dateutil"

cd ~/docker_scripts/

git pull

cd ~/

mkdir -p /home/${USER}/py2deb3

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-10 libhdf5-dev libxml2-dev libxslt1-dev \
                        libpython3.7-dev freetds-bin freetds-dev udev libgeos++-dev pandoc \
                        libfreetype6-dev libpng-dev libmysqlclient-dev swig pkg-config

sudo apt-get install -y python3-pip
sudo pip3 install py2deb

py2deb -r /home/${USER}/py2deb3 -y $OPTS -- \
    --upgrade git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1 2>&1 >> build.log
py2deb -r /home/${USER}/py2deb3 -y $OPTS -- \
    --upgrade git+https://github.com/ddboline/py2deb.git@1.1-1 2>&1 >> build.log

scp /home/${USER}/py2deb3/*.deb build.log \
    ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb3/py2deb3/
