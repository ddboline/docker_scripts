#!/bin/bash

cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get \
    -o Dpkg::Options::=--force-confold \
    -o Dpkg::Options::=--force-confdef \
    -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    install -yq postgresql-server-dev-12 libhdf5-dev libxml2-dev libxslt1-dev libpython3.8-dev \
                freetds-bin freetds-dev udev libfreetype6-dev libpng-dev pkg-config \
                libgeos-dev pandoc libmysqlclient-dev swig librdkafka-dev llvm-10 \
                libproj-dev proj-bin

sudo ln -s /usr/bin/llvm-config-10 /usr/bin/llvm-config

touch build.log
md5sum /home/${USER}/output/*.deb > existing.log

./docker_scripts/build_python3_wheel2deb.sh wheel2deb 2>&1 >> build.log
./docker_scripts/build_python3_wheel2deb.sh python-dateutil pytz 2>&1 >> build.log
./docker_scripts/build_python3_wheel2deb.sh cython mock 2>&1 >> build.log
./docker_scripts/build_python3_wheel2deb.sh numpy scipy pandas matplotlib 2>&1 >> build.log
./docker_scripts/build_python3_wheel2deb.sh poetry 2>&1 >> build.log
./docker_scripts/build_python3_wheel2deb.sh maturin 2>&1 >> build.log
./docker_scripts/build_python3_wheel2deb.sh dlint 2>&1 >> build.log

md5sum /home/${USER}/output/*.deb > modified.log
MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
sudo sed -i 's/numpy (<< 1:/numpy (<< /g' /var/lib/dpkg/status
sudo dpkg --force-overwrite -i $MODIFIED
sudo apt-get -o Dpkg::Options::="--force-overwrite" install -f -y --force-yes
mv modified.log existing.log

MODIFIED=/home/${USER}/output/*.deb
if [ -n "$MODIFIED" ]; then
    scp $MODIFIED build.log ubuntu@cloud.ddboline.net:/home/ubuntu/setup_files/deb/py2deb3/focal/py2deb3/
fi
