# Base docker image
FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

ADD google-chrome.list /etc/apt/sources.list.d/google-chrome.list

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/ubuntu && \
    echo "ubuntu:x:${uid}:${gid}:Developer,,,:/home/ubuntu:/bin/bash" >> /etc/passwd && \
    echo "ubuntu:x:${uid}:" >> /etc/group && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ubuntu && \
    chmod 0440 /etc/sudoers.d/ubuntu && \
    chown ${uid}:${gid} -R /home/ubuntu

USER ubuntu
ENV HOME /home/ubuntu

# Install Chromium
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key A040830F7FAC5991 && \
    sudo apt-get update && sudo apt-get install -y google-chrome-stable

RUN mkdir -p /home/ubuntu/Downloads

# Autorun x11vnc
CMD ["/usr/bin/google-chrome-stable", "--no-sandbox", "--user-data-dir=/home/ubuntu/Downloads"]
