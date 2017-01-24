#!/bin/bash

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev \
                        libxslt1-dev libpython2.7-dev freetds-bin freetds-dev udev

./build_python_deb.sh packaging appdirs
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/cached-property.git@1.3.0.1
./build_python_deb.sh git+https://github.com/ddboline/chardet.git@2.3.0.1
./build_python_deb.sh git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1
./build_python_deb.sh git+https://github.com/ddboline/python-deb-pkg-tools.git@3.0-1
./build_python_deb.sh git+https://github.com/ddboline/py2deb.git@0.24.3.2

./build_python_deb.sh cython
sudo dpkg -i ~/py2deb/cython_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.12.0-1
sudo dpkg -i ~/py2deb/python-numpy_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/scipy.git@v0.18.1-1
sudo dpkg -i ~/py2deb/python-scipy_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh python-dateutil pytz cycler
sudo dpkg -i ~/py2deb/*dateutil*.deb ~/py2deb/*tz*.deb ~/py2deb/*cycler*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh pandas matplotlib mock pyparsing pbr
sudo dpkg -i ~/py2deb/python-pandas_*.deb ~/py2deb/python-matplotlib_*.deb \
        ~/py2deb/python-mock_*.deb ~/py2deb/python-pyparsing_*.deb \
        ~/py2deb/python-pbr_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb/python-entrypoints_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/spyder-ide/spyder.git@v2.3.9

for PKG in `cat run_python_deb_pkgs.txt`;
do
    ./docker_scripts/build_python_deb.sh $PKG
done
