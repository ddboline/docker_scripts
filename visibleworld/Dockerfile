FROM		ubuntu:xenial
MAINTAINER	Daniel Boline <danielb@visibleworld.com>

RUN mkdir -p /home/ubuntu
ADD     keys_vworld.tar.gz /home/ubuntu/
ADD     keys_vworld.tar.gz /root/
ADD     build_python_deb.sh /home/ubuntu/
ADD	run_python_deb_build.sh /home/ubuntu
ADD	build_universe_api.sh /home/ubuntu

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y git sudo postgresql-server-dev-9.5
RUN apt-key add /root/ddboline_711C1DEB.gpg
RUN chown -R root:root /root
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    mkdir /home/ubuntu/tmp && \
    git clone https://github.com/ddboline/docker_scripts.git /home/ubuntu/docker_scripts && \
    mkdir -p /home/ubuntu/.pip && \
    printf "[global]\n\nindex-url = https://repos.visibleworld.com/artifactory/api/pypi/pypi-virtual/simple\n" >> /home/ubuntu/.pip/pip.conf && \
    chown ${uid}:${gid} -R /home/ubuntu

RUN sudo bash -c "echo deb ssh://danielb@alg-dev01.visibleworld.com/home/danielb/setup_files/var/www/html/deb/xenial/solver_python ./ > /etc/apt/sources.list.d/py2deb.list"
RUN sudo bash -c "echo deb ssh://danielb@alg-dev01.visibleworld.com/home/danielb/setup_files/var/www/html/deb/xenial/python3/solver_python ./ > /etc/apt/sources.list.d/py2deb3.list"

USER ubuntu
ENV USER ubuntu
ENV HOME /home/ubuntu
ENV LANG C.UTF-8
ENV LANGUAGE en_US:en
