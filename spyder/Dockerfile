# Base docker image
FROM ddboline/ddboline_keys:conda_latest
MAINTAINER Daniel Boline <ddboline@gmail.com>

# Install Chromium
RUN /opt/conda/bin/conda install --yes spyder

# Autorun x11vnc
# CMD ["/usr/bin/google-chrome-stable", "--no-sandbox", "--user-data-dir=/home/ubuntu/Downloads"]
