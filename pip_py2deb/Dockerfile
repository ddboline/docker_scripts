# Base docker image
FROM ddboline/ddboline_keys:v1.0.0.0
MAINTAINER Daniel Boline <ddboline@gmail.com>


RUN sudo /bin/bash -c "echo America/New_York > /etc/timezone" && \
    sudo ln -s /usr/share/zoneinfo/America/New_York /etc/localtime && \
    sudo apt-get update && sudo apt-get install -y tzdata

RUN sudo bash -c "echo deb ssh://ddboline@ddbolineathome.mooo.com/var/www/html/deb/bionic/devel ./ > /etc/apt/sources.list.d/py2deb.list"
RUN sudo apt-get update
RUN sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y \
                                        python-pip python-dev lintian liblapack-dev libblas-dev \
                                        dpkg-dev gfortran libfreetype6-dev libpng-dev pkg-config \
                                        python-setuptools python-py2deb git-buildpackage libhdf5-dev \
                                        libexif-dev libjpeg-dev liblcms2-dev libtiff5-dev zlib1g-dev \
                                        freetds-dev libmysqlclient-dev pandoc swig
RUN mkdir -p /home/ubuntu/py2deb
RUN sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
RUN cd /home/ubuntu/docker_scripts && sudo -u ubuntu git pull
