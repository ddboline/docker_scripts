#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev libxslt1-dev libpython2.7-dev \
                        freetds-bin freetds-dev udev

./docker_scripts/build_python_deb.sh packaging appdirs cython
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh setuptools
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

### Use forked repos to handle annoying bugs...
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.12.0-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/scipy.git@v0.18.1-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh python-dateutil pytz cycler pandas matplotlib mock pyparsing pbr theano
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/openant.git

for PKG in `cat ./docker_scripts/run_python_deb_pkgs.txt`;
do
    ./docker_scripts/build_python_deb.sh $PKG
done

./docker_scripts/build_coin.sh
./docker_scripts/build_fit2tcx.sh

### For the record, I really don't like python packages that depend on f***ing node...
# ./docker_scripts/build_python_deb.sh jupyter

# md5sum /home/${USER}/py2deb/*.deb > modified.log
# MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
MODIFIED=/home/${USER}/py2deb/*.deb
if [ -n "$MODIFIED" ]; then
    ssh ubuntu@ddbolineinthecloud.mooo.com "mkdir -p /home/ubuntu/setup_files/deb/py2deb/py2deb"
    scp $MODIFIED ubuntu@ddbolineinthecloud.mooo.com:/home/ubuntu/setup_files/deb/py2deb/py2deb/
    scp $MODIFIED ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb/py2deb/
fi
