#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-10 libhdf5-dev libxml2-dev libxslt1-dev libpython2.7-dev \
                        freetds-bin freetds-dev udev libfreetype6-dev libpng-dev pkg-config \
                        libgeos-dev pandoc libmysqlclient-dev swig librdkafka-dev

touch build.log
md5sum /home/${USER}/py2deb/*.deb > existing.log
for PKG in `cat ./docker_scripts/run_python_deb_pkgs.txt`;
do
    ./docker_scripts/build_python_deb.sh $PKG 2>&1 >> build.log
    rm -rf /tmp/pip-*-build
    rm -rf /home/${USER}/py2deb/python-pip_10*.deb
    md5sum /home/${USER}/py2deb/*.deb > modified.log
    MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
    sudo sed -i 's/numpy (<< 1:/numpy (<< /g' /var/lib/dpkg/status
    sudo dpkg --force-overwrite -i $MODIFIED
    sudo apt-get -o Dpkg::Options::="--force-overwrite" install -f -y --force-yes
    mv modified.log existing.log
done

MODIFIED=/home/${USER}/py2deb/*.deb
if [ -n "$MODIFIED" ]; then
#     scp $MODIFIED build.log ddboline@home.ddboline.net:/home/ddboline/setup_files/deb/py2deb/bionic/py2deb/
    scp $MODIFIED build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb/bionic/py2deb/
fi
