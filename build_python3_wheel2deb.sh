#!/bin/bash

OPTS="pyyaml=yaml pyusb=usb websockify=websockify3
      scikit-learn=sklearn scikit-image=skimage
      google-api-python-client=googleapi cython=cython3
      pytz=tz pillow=pil python-debian=debian
      beautifulsoup4=bs4 compose=docker-compose
      pyzmq=zmq spyder=spyder3 ipython=ipython3
      pylint=pylint3 pyflakes=pyflakes3 python-dateutil=dateutil"

### hack...
export LANG="C.UTF-8"

REPOS="$@"
if [ -z "$REPOS" ]; then
    REPOS=""
fi

if [ ! -e "/usr/bin/wheel2deb" ]; then
#     sudo bash -c "echo deb [trusted=yes] https://py2deb-repo.s3.amazonaws.com/deb/focal/python3 focal main > /etc/apt/sources.list.d/py2deb3.list"
# 
#     sudo apt-get update
#     sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y --force-yes \
#                                 python3-pip python3-wheel2deb python3-dev lintian liblapack-dev libblas-dev \
#                                 dpkg-dev gfortran libfreetype6-dev libpng-dev pkg-config \
#                                 python3-setuptools libsnappy-dev
    sudo apt-get update
    sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y --force-yes \
                                python3-pip python3-dev lintian liblapack-dev libblas-dev \
                                dpkg-dev gfortran libfreetype6-dev libpng-dev pkg-config \
                                libsnappy-dev
    sudo pip3 install wheel2deb
    mkdir -p /home/${USER}/output
fi

md5sum /home/${USER}/output/*.deb > existing.log

for REPO in $REPOS;
do
    pip3 install $REPO
    pip3 wheel $REPO
done

wheel2deb --map $OPTS
wheel2deb build -i *.whl
wheel2deb --map $OPTS --ignore-entry-points --ignore-upstream-version
wheel2deb build -i *.whl
