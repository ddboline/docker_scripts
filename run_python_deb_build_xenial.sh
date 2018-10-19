#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev libxslt1-dev \
                        libpython2.7-dev freetds-bin freetds-dev udev libgeos++-dev pandoc \
                        libfreetype6-dev libpng12-dev libmysqlclient-dev swig

touch build.log
md5sum /home/${USER}/py2deb/*.deb > existing.log
for PKG in `cat ./docker_scripts/run_python_deb_pkgs.txt`;
do
    ./docker_scripts/build_python_deb.sh $PKG 2>&1 >> build.log
    rm -rf /tmp/pip-*-build
    rm -rf /home/${USER}/py2deb/python-pip_10*.deb
    md5sum /home/${USER}/py2deb/*.deb > modified.log
    MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
    sudo dpkg --force-overwrite -i $MODIFIED
    sudo apt-get -o Dpkg::Options::="--force-overwrite" install -f -y --force-yes
    mv modified.log existing.log
done

./docker_scripts/build_coin.sh 2>&1 >> build.log
./docker_scripts/build_fit2tcx.sh 2>&1 >> build.log
./docker_scripts/build_efs_utils.sh 2>&1 >> build.log

MODIFIED=/home/${USER}/py2deb/*.deb
if [ -n "$MODIFIED" ]; then
    scp $MODIFIED build.log ddboline@home.ddboline.net:/home/ddboline/setup_files/deb/py2deb/xenial/py2deb/
fi
