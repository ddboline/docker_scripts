#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-10 libhdf5-dev libxml2-dev libxslt1-dev libpython3.6-dev \
                        freetds-bin freetds-dev udev libfreetype6-dev libpng-dev pkg-config \
                        libgeos-dev pandoc libmysqlclient-dev swig

touch build.log
md5sum /home/${USER}/py2deb3/*.deb > existing.log
for PKG in `cat ./docker_scripts/run_python3_deb_pkgs.txt`;
do
    ./docker_scripts/build_python3_deb.sh $PKG 2>&1 >> build.log
    rm -rf /tmp/pip-*-build
    rm -rf /home/${USER}/py2deb3/python3-pip_10*.deb
    md5sum /home/${USER}/py2deb3/*.deb > modified.log
    MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
    sudo sed -i 's/numpy (<< 1:/numpy (<< /g' /var/lib/dpkg/status
    sudo dpkg --force-overwrite -i $MODIFIED
    sudo apt-get -o Dpkg::Options::="--force-overwrite" install -f -y --force-yes
    mv modified.log existing.log
done

./docker_scripts/build_fit2tcx.sh 2>&1 >> build.log
./docker_scripts/build_efs_utils.sh 2>&1 >> build.log
./docker_scripts/build_garmin_rust.sh 2>&1 >> build.log
./docker_scripts/build_rust_auth.sh 2>&1 >> build.log

MODIFIED=/home/${USER}/py2deb3/*.deb
if [ -n "$MODIFIED" ]; then
    scp $MODIFIED build.log ddboline@home.ddboline.net:/home/ddboline/setup_files/deb/py2deb3/bionic/py2deb3/
    scp $MODIFIED build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/bionic/py2deb3/
fi
