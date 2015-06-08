# Base docker image
FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

ADD google-chrome.list /etc/apt/sources.list.d/google-chrome.list

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

# Install Chromium
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key A040830F7FAC5991 && \
    sudo apt-get update && sudo apt-get install -y google-chrome-stable

RUN mkdir -p /home/developer/Downloads

# Autorun x11vnc
CMD ["/usr/bin/google-chrome-stable", "--no-sandbox", "--user-data-dir=/home/developer/Downloads"]
