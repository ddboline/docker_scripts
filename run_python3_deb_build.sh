#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev libxslt1-dev libpython3.5-dev udev

./docker_scripts/build_python3_deb.sh packaging appdirs
sudo dpkg -i ~/py2deb3/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/cached-property.git@1.3.0.1
./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/chardet.git@2.3.0.1
./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1
./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/python-deb-pkg-tools.git@3.0-1
./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/py2deb.git@0.24.3.2

### Need recent cython installed to build numpy, need numpy for various other projects...
./docker_scripts/build_python3_deb.sh cython
sudo dpkg -i ~/py2deb3/*.deb
sudo apt-get install -f -y --force-yes

### Use forked repos to handle annoying bugs...
./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/numpy.git@v1.12.0-1
sudo dpkg -i ~/py2deb3/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/scipy.git@v0.18.1-1
sudo dpkg -i ~/py2deb3/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python3_deb.sh pandas matplotlib mock pyparsing pbr cycler
sudo dpkg -i ~/py2deb3/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python3_deb.sh theano
sudo dpkg -i ~/py2deb3/*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb3/*.deb
sudo apt-get install -f -y --force-yes

for PKG in `cat ./docker_scripts/run_python3_deb_pkgs.txt`;
do
    ./docker_scripts/build_python3_deb.sh $PKG
done

./docker_scripts/build_fit2tcx.sh

### For the record, I really don't like python packages that depend on f***ing node...
# sudo apt-get install -y npm
# sudo ln -s /usr/bin/nodejs /usr/bin/node
# ./docker_scripts/build_python3_deb.sh jupyter

# md5sum /home/${USER}/py2deb3/*.deb > modified.log
# MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
MODIFIED=/home/${USER}/py2deb3/*.deb
if [ -n "$MODIFIED" ]; then
    ssh ubuntu@ddbolineinthecloud.mooo.com "mkdir -p /home/ubuntu/setup_files/deb/py2deb3/py2deb3"
    scp $MODIFIED ubuntu@ddbolineinthecloud.mooo.com:/home/ubuntu/setup_files/deb/py2deb3/py2deb3/
    scp $MODIFIED ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb3/py2deb3/
fi
