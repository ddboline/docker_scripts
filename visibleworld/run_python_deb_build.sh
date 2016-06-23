#!/bin/bash

sudo apt-get install -y postgresql-server-dev-9.3
sudo apt-get install -y libhdf5-dev
sudo apt-get install -y freetds-bin freetds-dev

./build_python_deb.sh setuptools
sudo dpkg -i ~/py2deb/python-setuptools_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh cython
sudo dpkg -i ~/py2deb/cython_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.11.0-1
sudo dpkg -i ~/py2deb/python-numpy_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh openpyxl pika psycopg2 requests pandas python-logstash jsonschema test-helper
./build_python_deb.sh futures scipy matplotlib spyder sqlalchemy statsmodels tables vcrpy vcrpy-unittest
./build_python_deb.sh jinja2 pyparsing wheel py2deb pip

sudo dpkg -i ~/py2deb/python-scipy_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh scikit-learn
./build_python_deb.sh pymssql sqlacodegen
./build_python_deb.sh bitstring deap funcsigs functools32 
sudo dpkg -i ~/py2deb/python-pandas_*.deb ~/py2deb/python-dateutil_*.deb ~/py2deb/python-tz_*.deb ~/py2deb/python-sklearn_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh mock pbr sklearn-compiledtrees sklearn-pandas wrapt pyyaml
./build_python_deb.sh git+https://github.com/rsteca/sklearn-deap.git
./build_python_deb.sh py4j pyprof2calltree python-Levenshtein sharedarray
./build_python_deb.sh records pytest html hypothesis dask
./build_python_deb.sh slackclient
