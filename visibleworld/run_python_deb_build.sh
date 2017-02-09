#!/bin/bash

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev \
                        libxslt1-dev libpython2.7-dev freetds-bin freetds-dev udev

./build_python_deb.sh packaging appdirs git+https://github.com/ddboline/cython@0.25.2.1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

### Use forked repos to handle annoying bugs...
./build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.12.0-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/scipy.git@v0.18.1-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh python-dateutil pytz cycler
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh python-dateutil pytz cycler pandas matplotlib mock pyparsing pbr theano
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/spyder-ide/spyder.git@v2.3.9

for PKG in `cat run_python_deb_pkgs.txt`;
do
    ./build_python_deb.sh $PKG
done
