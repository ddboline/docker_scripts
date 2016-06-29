cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get update
sudo apt-get install -y postgresql-server-dev-9.3 libhdf5-dev libxml2-dev libxslt1-dev

### Need recent cython installed to build numpy, need numpy for various other projects...
./docker_scripts/build_python_deb.sh cython
sudo dpkg -i ~/py2deb/cython_*.deb
sudo apt-get install -f -y --force-yes

### Use forked repos to handle annoying bugs...
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/numpy.git@v1.11.1-1
sudo dpkg -i ~/py2deb/python-numpy_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh scipy
sudo dpkg -i ~/py2deb/python-scipy_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh pandas matplotlib mock nose pyparsing pbr
sudo dpkg -i ~/py2deb/python-pandas_*.deb ~/py2deb/python-matplotlib_*.deb \
        ~/py2deb/python-mock_*.deb ~/py2deb/python-nose_*.deb ~/py2deb/python-pyparsing_*.deb \
        ~/py2deb/python-pbr_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh theano
sudo dpkg -i ~/py2deb/python-theano_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh statsmodels websockify sharedarray requests pysparkling
./docker_scripts/build_python_deb.sh pystan seaborn patsy enum34 executor pip
./docker_scripts/build_python_deb.sh py2deb youtube-dl py4j setuptools pytz python-dateutil
./docker_scripts/build_python_deb.sh scikit-learn scikit-image blaze gensim nltk
./docker_scripts/build_python_deb.sh lasagne nolearn scikit-neuralnetwork keras gdbn h5py
./docker_scripts/build_python_deb.sh asyncio boltons beautifulsoup4 cssselect cytoolz lxml pandasql pillow
./docker_scripts/build_python_deb.sh units xray sqlacodegen
./docker_scripts/build_python_deb.sh fuzzywuzzy spyder pymonad pyquery click pyscaffold onedrivesdk
./docker_scripts/build_python_deb.sh pytest pytest-xdist pytest-instafail pyprof2calltree getlyrics wget
./docker_scripts/build_python_deb.sh ipython coverage openpyxl pika python-logstash jsonschema test-helper
./docker_scripts/build_python_deb.sh onedrivesdk boxsdk dropbox eventlet
./docker_scripts/build_python_deb.sh jinja2 nuitka numexpr pexpect tables
./docker_scripts/build_python_deb.sh deap tpot pyusb imagehash
./docker_scripts/build_python_deb.sh cloudpickle et_xmlfile flexx greenlet ipython_genutils
./docker_scripts/build_python_deb.sh jdcal lockfile markupsafe odfpy openpyxl
./docker_scripts/build_python_deb.sh wheel traitlets simplegeneric pickleshare path.py
./docker_scripts/build_python_deb.sh pdfkit ptyprocess python-debian pyyaml requests-toolbelt
./docker_scripts/build_python_deb.sh protobuf protobuf-setuptools setuptools_scm
./docker_scripts/build_python_deb.sh psycopg2 scalafunctional python-Levenshtein futures boxsdk
./docker_scripts/build_python_deb.sh records validictory pydrive hypothesis dask

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/compose.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/pulp.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/pylearn2.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/garmin_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/roku_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/security_log_analysis.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/sync_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/movie_collection_app.git
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/pip-accel.git@0.43-2
./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/python-deb-pkg-tools.git@1.36-1

OPTS="--rename=pyyaml,python-yaml --rename=pyusb,python-usb --rename=websockify,websockify 
      --rename=scikit-learn,python-sklearn --rename=scikit-image,python-skimage 
      --rename=google-api-python-client,python-googleapi --rename=cython,cython
      --rename=pytz,python-tz --rename=pillow,python-pil
      --rename=beautifulsoup4,python-bs4"


sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade git+https://github.com/Tigge/openant.git
sudo dpkg -i ~/py2deb/python-usb_*.deb
sudo dpkg -i ~/py2deb/python-openant_*.deb
sudo apt-get install -f -y --force-yes
sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade git+https://github.com/Tigge/antfs-cli.git
sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade spacy preshed

sudo chown ${USER}:${USER} ~/py2deb/*.deb


./docker_scripts/build_fit2tcx.sh

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/stravalib.git

./docker_scripts/build_xgboost.sh

scp ~/py2deb/*.deb ubuntu@ddbolineinthecloud.mooo.com:~/setup_files/deb/py2deb/py2deb/
