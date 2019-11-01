#!/bin/bash

cd ~/docker_scripts/rust_nightly

make && make push

docker rmi `docker images | awk '/rust_nightly/ {print $3}' | sort | uniq`

cd ~/docker_scripts/rust_stable

make amazon && make push_amazon

docker rmi `docker images | awk '/rust_stable/ && /amazon/ {print $3}' | sort | uniq`

make && make push

for PKGS in "fd-find,fd" "exa,exa" "bat,bat" "du-dust,dust";
do
    PACKAGE=`echo $PKGS | sed 's:,: :g' | awk '{print $1}'`;
    EXE=`echo $PKGS | sed 's:,: :g' | awk '{print $2}'`;
    UNIQ=`head -c1000 /dev/urandom | sha512sum | head -c 12 ; echo`;
    CIDFILE="/tmp/.tmp.docker.${UNIQ}";
    docker run --cidfile ${CIDFILE} rust_stable:latest /root/build_rust_pkg.sh ${PACKAGE} ${EXE}
    docker cp `cat ${CIDFILE}`:/root/${PACKAGE}/${EXE}_${VERSION}-${RELEASE}_amd64.deb .
    docker rm `cat ${CIDFILE}`
    rm ${CIDFILE}
done

cd ~/
