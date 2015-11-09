#!/bin/bash

sudo apt-get install -y postgresql-server-dev-9.3
sudo apt-get install -y libhdf5-dev

./build_python_deb.sh openpyxl pika psycopg2 requests pandas numpy python-logstash jsonschema test-helper cython

sudo dpkg -i ~/py2deb/python-numpy_*.deb ~/py2deb/cython_*.deb
sudo apt-get install -f -y --force-yes

./build_python_deb.sh futures scipy matplotlib spyder sqlalchemy statsmodels tables vcrpy vcrpy-unittest
./build_python_deb.sh jinja2 pyparsing wheel py2deb
