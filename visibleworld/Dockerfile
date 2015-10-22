FROM		ubuntu:14.04.2
MAINTAINER	Daniel Boline <danielb@visibleworld.com>

RUN mkdir -p /home/ubuntu
ADD     keys_vworld.tar.gz /home/ubuntu/
ADD     keys_vworld.tar.gz /root/
ADD     hosts /home/ubuntu/hosts
ADD     build_python_deb.sh /home/ubuntu/

RUN apt-get update && apt-get install -y git sudo
RUN cp -a /home/ubuntu/.ssh /root/ && chown -R root:root /root

RUN export uid=1000 gid=1000 && \
    mkdir -p /etc/sudoers.d && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu && \
    cat /home/ubuntu/hosts >> /etc/hosts

USER ubuntu
ENV USER ubuntu
ENV HOME /home/ubuntu
ENV LANG C.UTF-8
ENV LANGUAGE en_US:en
