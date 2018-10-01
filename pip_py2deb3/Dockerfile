# Base docker image
FROM ddboline/ddboline_keys:v1.0.0.0
MAINTAINER Daniel Boline <ddboline@gmail.com>

RUN sudo bash -c "echo deb ssh://ddboline@home.ddboline.net/var/www/html/deb/bionic/python3/devel ./ > /etc/apt/sources.list.d/py2deb.list"
RUN sudo apt-get update
RUN sudo apt-get -o Dpkg::Options::="--force-overwrite" install -y \
                                        python3-pip python3-dev lintian liblapack-dev libblas-dev \
                                        dpkg-dev gfortran libfreetype6-dev libpng-dev pkg-config \
                                        python3-setuptools python3-py2deb libhdf5-dev \
                                        libexif-dev libjpeg-dev liblcms2-dev libtiff5-dev zlib1g-dev \
                                        freetds-dev libmysqlclient-dev pandoc swig
RUN mkdir -p /home/ubuntu/py2deb3
RUN sudo apt-get autoremove && sudo apt-get autoclean && sudo rm -rf /var/cache/apt/archives/*.deb
# This is a terrible hack...
RUN sudo rm -rf /usr/lib/python3/dist-packages/pkg_resources
RUN cd /home/ubuntu/docker_scripts && sudo -u ubuntu git pull
