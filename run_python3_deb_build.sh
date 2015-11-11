cd ~/docker_scripts/

git pull

cd ~/

sudo apt-get install -y postgresql-server-dev-9.3
sudo apt-get install -y libhdf5-dev

./docker_scripts/build_python3_deb.sh cython
sudo dpkg -i ~/py2deb3/cython_*.deb
sudo apt-get install -f -y --force-yes

git clone https://github.com/numpy/numpy.git
cd numpy
git checkout v1.10.1
python3 setup.py build
~/docker_scripts/build_python3_deb.sh .
cd ~/

# ./docker_scripts/build_python3_deb.sh setuptools
# sudo apt-get remove -y python3-pkg-resources
# sudo dpkg -i ~/py2deb3/python3-setuptools_*.deb
# sudo apt-get install -f -y --force-yes
# 
# ./docker_scripts/build_python3_deb.sh scipy
# sudo dpkg -i ~/py2deb3/python3-scipy_*.deb
# sudo apt-get install -f -y --force-yes

# ./docker_scripts/build_python3_deb.sh py2deb youtube-dl py4j
# sudo dpkg -i ~/py2deb3/python3-numpy_*.deb
# sudo apt-get install -f -y --force-yes
# ./docker_scripts/build_python3_deb.sh pandas matplotlib mock nose pyparsing pbr
# ./docker_scripts/build_python3_deb.sh scikit-learn scikit-image blaze gensim nltk
# sudo dpkg -i ~/py2deb3/python3-pandas_*.deb ~/py2deb3/python3-matplotlib_*.deb \
#         ~/py2deb3/python3-mock_*.deb ~/py2deb3/python3-nose_*.deb ~/py2deb3/python3-pyparsing_*.deb \
#         ~/py2deb3/python3-pbr_*.deb
# sudo apt-get install -f -y --force-yes
# ./docker_scripts/build_python3_deb.sh statsmodels websockify sharedarray requests pysparkling
# ./docker_scripts/build_python3_deb.sh pystan seaborn theano patsy enum34 executor
# sudo dpkg -i ~/py2deb3/python3-theano_*.deb 
# sudo apt-get install -f -y --force-yes
# 
# ./docker_scripts/build_python3_deb.sh lasagne nolearn scikit-neuralnetwork keras gdbn h5py
# ./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/pylearn2.git
# ./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/garmin_app.git
# ./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/roku_app.git \
#                                      git+https://github.com/ddboline/security_log_analysis.git \
#                                      git+https://github.com/ddboline/sync_app.git
# 
# OPTS="--rename=pyyaml,python3-yaml --rename=pyusb,python3-usb --rename=websockify,websockify 
#       --rename=scikit-learn,python3-sklearn --rename=scikit-image,python3-skimage 
#       --rename=google-api-python3-client,python3-googleapi --rename=cython,cython
#       --rename=pytz,python3-tz --rename=pillow,python3-pil
#       --rename=beautifulsoup4,python3-bs4"
# 
# 
# sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade git+https://github.com/Tigge/openant.git
# sudo dpkg -i ~/py2deb3/python3-usb_*.deb
# sudo dpkg -i ~/py2deb3/python3-openant_*.deb
# sudo apt-get install -f -y --force-yes
# sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade git+https://github.com/Tigge/antfs-cli.git
# sudo py2deb -r /home/${USER}/py2deb -y $OPTS -- --upgrade spacy
# 
# sudo chown ${USER}:${USER} ~/py2deb3/*.deb
# 
# ./docker_scripts/build_python3_deb.sh psycopg2
# 
# ./docker_scripts/build_fit2tcx.sh
# 
# ./docker_scripts/build_python3_deb.sh asyncio boltons beautifulsoup4 cssselect cytoolz lxml pandasql pillow
# ./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/stravalib.git
# ./docker_scripts/build_python3_deb.sh units xray sqlacodegen
# 
# ./docker_scripts/build_python3_deb.sh fuzzywuzzy spyder pymonad pyquery click pyscaffold onedrivesdk
# 
# ./docker_scripts/build_python3_deb.sh git+https://github.com/ddboline/compose.git
# 
# ./docker_scripts/build_python3_deb.sh pytest pytest-xdist pytest-instafail
# 
# ./docker_scripts/build_xgboost.sh
# 
# scp ~/py2deb3/*.deb ddboline@ddbolineathome.mooo.com:~/setup_files/deb/py2deb/py2deb/
