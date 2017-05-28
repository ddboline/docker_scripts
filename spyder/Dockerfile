# Base docker image
FROM ddboline/ddboline_keys:conda_latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

# Install Chromium
RUN sudo apt-get update && sudo apt-get install -y spyder

ENV QT_X11_NO_MITSHM 1
# Autorun x11vnc
CMD ["/usr/bin/spyder"]
