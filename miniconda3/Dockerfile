FROM ddboline/ddboline_keys:latest

MAINTAINER Daniel Boline <ddboline@gmail.com>

RUN sudo apt-get update && sudo apt-get install -y wget bzip2 ca-certificates
RUN sudo sh -c "echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh" && \
    sudo wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sudo /bin/bash /Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    sudo rm Miniconda3-latest-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH
