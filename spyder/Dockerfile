# Base docker image
FROM ddboline/ddboline_keys:conda_latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

# Install Chromium
RUN sudo apt-get update && sudo apt-get install -y libxext6 libglib2.0-0 libsm6 libice6 libxrender1
RUN sudo /opt/conda/bin/conda install --yes spyder

# Autorun x11vnc
# CMD ["/usr/bin/google-chrome-stable", "--no-sandbox", "--user-data-dir=/home/ubuntu/Downloads"]
