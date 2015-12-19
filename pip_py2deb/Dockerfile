# Base docker image
FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

RUN sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/trusty/devel ./ > /etc/apt/sources.list.d/py2deb.list"
RUN sudo apt-get update
RUN sudo apt-get install -y --force-yes python-pip python-dev lintian liblapack-dev libblas-dev \
                               dpkg-dev gfortran libfreetype6-dev libpng12-dev pkg-config \
                               python-setuptools python-py2deb
RUN mkdir -p /home/ubuntu/py2deb
RUN sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
