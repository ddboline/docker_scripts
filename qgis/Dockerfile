FROM ddboline/ddboline_keys:latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

COPY qgis.list /etc/apt/sources.list.d/qgis.list

# Install Chromium

RUN sudo mkdir -p /root/.gnupg && \
    sudo gpg --no-default-keyring --keyring /usr/share/keyrings/qgis-keyring.gpg --keyserver keyserver.ubuntu.com --recv-keys CAEB3DC3BDF7FB45 && \
    sudo apt-get update && sudo apt-get install -y qgis && \
    sudo rm -rf /var/cache/apt/archives/*.deb

# Autorun x11vnc
ENV QT_X11_NO_MITSHM 1
CMD ["/usr/bin/qgis"]
