FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

COPY google-chrome.list /etc/apt/sources.list.d/google-chrome.list

# Install Chromium
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key A040830F7FAC5991 && \
    sudo apt-get update && sudo apt-get install -y google-chrome-stable

RUN mkdir -p /home/ubuntu/Downloads

# Autorun x11vnc
CMD ["/usr/bin/google-chrome-stable", "--no-sandbox", "--user-data-dir=/home/ubuntu/Downloads"]
