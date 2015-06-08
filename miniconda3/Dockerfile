FROM ddboline/ddboline_keys:latest

MAINTAINER Daniel Boline <ddboline@gmail.com>

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-x86_64.sh
### && /opt/conda/bin/conda install --yes conda==3.10.1
#RUN /opt/conda/bin/conda install --yes blaze boto dateutil ipython lockfile lxml matplotlib numpy pandas pexpect pip psycopg2 pytz requests scikit-learn scipy theano

ENV PATH /opt/conda/bin:$PATH
