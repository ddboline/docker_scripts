FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

COPY qgis.list /etc/apt/sources.list.d/qgis.list

# Install Chromium
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 073D307A618E5811 && \
    sudo apt-get update && sudo apt-get install -y qgis && \
    sudo rm -rf /var/cache/apt/archives/*.deb

# Autorun x11vnc
ENV QT_X11_NO_MITSHM 1
CMD ["/usr/bin/qgis"]
