cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.5 libhdf5-dev libxml2-dev libxslt1-dev libpython2.7-dev udev

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/cached-property.git@1.3.0.1
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/chardet.git@2.3.0.1
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/pip-accel.git@pip-8.1-upgrade-1
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/python-deb-pkg-tools.git@3.0-1
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/py2deb.git@0.24.3.2

### Need recent cython installed to build numpy, need numpy for various other projects...
./docker_scripts/build_python_deb.sh cython
sudo dpkg -i ~/py2deb/cython_*.deb
sudo apt-get install -f -y --force-yes

### Use forked repos to handle annoying bugs...
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.11.3-1
sudo dpkg -i ~/py2deb/python-numpy_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/scipy.git@v0.18.1-1
sudo dpkg -i ~/py2deb/python-scipy_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh dateutil pytz cycler
sudo dpkg -i ~/py2deb/*dateutil*.deb ~/py2deb/*tz*.deb ~/py2deb/*cycler*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh pandas matplotlib mock nose2 pyparsing pbr
sudo dpkg -i ~/py2deb/python-pandas_*.deb ~/py2deb/python-matplotlib_*.deb \
        ~/py2deb/python-mock_*.deb ~/py2deb/python-nose2_*.deb ~/py2deb/python-pyparsing_*.deb \
        ~/py2deb/python-pbr_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh theano
sudo dpkg -i ~/py2deb/python-theano_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb/python-entrypoints_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh git+https://github.com/spyder-ide/spyder.git@v2.3.9

./docker_scripts/build_python_deb.sh statsmodels websockify sharedarray requests pysparkling
./docker_scripts/build_python_deb.sh pystan seaborn patsy enum34 executor pip
./docker_scripts/build_python_deb.sh youtube-dl py4j setuptools pytz python-dateutil
./docker_scripts/build_python_deb.sh scikit-learn scikit-image blaze gensim nltk
./docker_scripts/build_python_deb.sh lasagne nolearn scikit-neuralnetwork keras gdbn h5py
./docker_scripts/build_python_deb.sh asyncio boltons beautifulsoup4 cssselect cytoolz lxml pandasql pillow
./docker_scripts/build_python_deb.sh units xray sqlacodegen
./docker_scripts/build_python_deb.sh fuzzywuzzy pymonad pyquery click pyscaffold onedrivesdk
./docker_scripts/build_python_deb.sh pytest pytest-xdist pytest-instafail pyprof2calltree getlyrics wget
./docker_scripts/build_python_deb.sh ipython coverage openpyxl pika python-logstash jsonschema test-helper
./docker_scripts/build_python_deb.sh onedrivesdk boxsdk dropbox eventlet
./docker_scripts/build_python_deb.sh jinja2 nuitka numexpr pexpect tables
./docker_scripts/build_python_deb.sh deap tpot pyusb imagehash pylint
./docker_scripts/build_python_deb.sh cloudpickle et_xmlfile flexx greenlet ipython_genutils
./docker_scripts/build_python_deb.sh jdcal lockfile markupsafe odfpy openpyxl
./docker_scripts/build_python_deb.sh wheel traitlets simplegeneric pickleshare path.py
./docker_scripts/build_python_deb.sh pdfkit ptyprocess python-debian pyyaml requests-toolbelt
./docker_scripts/build_python_deb.sh protobuf protobuf-setuptools setuptools_scm
./docker_scripts/build_python_deb.sh psycopg2 scalafunctional python-Levenshtein futures boxsdk
./docker_scripts/build_python_deb.sh records validictory pydrive hypothesis dask retrying
./docker_scripts/build_python_deb.sh attrs mypy-lang sphinx

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/compose.git@1.9.0.1
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/pulp.git@1.6.1-1
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/pylearn2.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/garmin_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/roku_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/security_log_analysis.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/sync_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/movie_collection_app.git

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/openant.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/antfs-cli.git

# sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade spacy preshed
# sudo chown ${USER}:${USER} ~/py2deb/*.deb

./docker_scripts/build_coin.sh
./docker_scripts/build_fit2tcx.sh

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/stravalib.git@0.6.6

### For the record, I really don't like python packages that depend on f***ing node...
# ./docker_scripts/build_python_deb.sh jupyter

# md5sum /home/${USER}/py2deb/*.deb > modified.log
# MODIFIED=`diff -u existing.log modified.log | awk '$1 ~ /\+/ && $1 != "+++" {I=I" "$2} END{print I}'`
MODIFIED=/home/${USER}/py2deb/*.deb
if [ -n "$MODIFIED" ]; then
    ssh ubuntu@ddbolineinthecloud.mooo.com "mkdir -p /home/ubuntu/setup_files/deb/py2deb/py2deb"
    scp $MODIFIED ubuntu@ddbolineinthecloud.mooo.com:/home/ubuntu/setup_files/deb/py2deb/py2deb/
    scp $MODIFIED ddboline@ddbolineathome.mooo.com:/home/ddboline/setup_files/deb/py2deb/py2deb/
fi
