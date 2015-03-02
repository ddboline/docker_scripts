# Base docker image
FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

COPY /etc/apt/sources.list.d/google-chrome.list /etc/apt/sources.list.d/google-chrome.list

# Install Chromium
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key A040830F7FAC5991 && \
    apt-get update && apt-get install -y google-chrome-stable

RUN sed -i.bak 's/jessie main/jessie main contrib non-free/g' /etc/apt/sources.list && \
    mkdir -p /usr/share/icons/hicolor && \
    apt-get update && apt-get install -y \
    ca-certificates \
    gconf-service \
    libappindicator1 \
    libasound2 \
    libcanberra-gtk-module \
    libcurl3 \
    libexif-dev \
    libgconf-2-4 \
    libnspr4 \
    libnss3 \
    libpango1.0-0 \
    libv4l-0 \
    libxss1 \
    libxtst6 \
    wget \
    xdg-utils \
    --no-install-recommends && \
    dpkg -i '/src/google-chrome-stable_current_amd64.deb' && \
    apt-get install -y \
    pepperflashplugin-nonfree \
    --no-install-recommends && \
    dpkg -i '/src/google-talkplugin_current_amd64.deb'

COPY local.conf /etc/fonts/local.conf

# Autorun x11vnc
CMD ["/usr/bin/google-chrome-stable", "--no-sandbox", "--user-data-dir=/data"]
