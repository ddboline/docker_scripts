#!/bin/bash

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev \
                        libxslt1-dev libpython2.7-dev freetds-bin freetds-dev udev


./build_python_deb.sh git+https://github.com/ddboline/cached-property.git@1.3.0.1
./build_python_deb.sh git+https://github.com/ddboline/chardet.git@2.3.0.1
./build_python_deb.sh git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1
./build_python_deb.sh git+https://github.com/ddboline/python-deb-pkg-tools.git@3.0-1
./build_python_deb.sh git+https://github.com/ddboline/py2deb.git@0.24.3.2

./build_python_deb.sh setuptools
sudo dpkg -i ~/py2deb/python-setuptools_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh cython
sudo dpkg -i ~/py2deb/cython_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.11.3-1
sudo dpkg -i ~/py2deb/python-numpy_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/scipy.git@v0.18.1-1
sudo dpkg -i ~/py2deb/python-scipy_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh dateutil pytz cycler
sudo dpkg -i ~/py2deb/*dateutil*.deb ~/py2deb/*tz*.deb ~/py2deb/*cycler*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb/python-entrypoints_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh git+https://github.com/spyder-ide/spyder.git@v2.3.9

./build_python_deb.sh openpyxl pika psycopg2 requests pandas python-logstash jsonschema test-helper
./build_python_deb.sh futures scipy matplotlib sqlalchemy statsmodels tables vcrpy vcrpy-unittest
./build_python_deb.sh jinja2 pyparsing wheel py2deb pip sphinx

sudo dpkg -i ~/py2deb/python-scipy_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh scikit-learn
./build_python_deb.sh pymssql sqlacodegen pathos
./build_python_deb.sh bitstring deap funcsigs functools32
sudo dpkg -i ~/py2deb/python-pandas_*.deb ~/py2deb/python-dateutil_*.deb ~/py2deb/python-tz_*.deb ~/py2deb/python-sklearn_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh mock pbr sklearn-compiledtrees sklearn-pandas wrapt pyyaml
./build_python_deb.sh py4j pyprof2calltree python-Levenshtein sharedarray
./build_python_deb.sh records pytest html hypothesis dask mypy-lang
./build_python_deb.sh slackclient retrying attrs pytest-cov

./build_python_deb.sh jupyter

./build_python_deb.sh git+http://GitLab02.visibleworld.com/Data_Analytics/vwpy.git@v1.2.6-1
./build_python_deb.sh git+http://GitLab02.visibleworld.com/Data_Analytics/util_python.git@v1.0.2-2
./build_python_deb.sh git+http://GitLab02.visibleworld.com/Data_Analytics/vwasync.git@v1.0.0-2
./build_python_deb.sh git+http://GitLab02.visibleworld.com/Data_Analytics/pulp.git@v1.1.0-2
