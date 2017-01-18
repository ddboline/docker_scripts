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

./docker_scripts/build_python_deb.sh pandas matplotlib mock pyparsing pbr
sudo dpkg -i ~/py2deb/python-pandas_*.deb ~/py2deb/python-matplotlib_*.deb \
        ~/py2deb/python-mock_*.deb ~/py2deb/python-pyparsing_*.deb \
        ~/py2deb/python-pbr_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh theano
sudo dpkg -i ~/py2deb/python-theano_*.deb
sudo apt-get install -f -y --force-yes

./docker_scripts/build_python_deb.sh git+https://github.com/ddboline/entrypoints.git@0.2.2-1
sudo dpkg -i ~/py2deb/python-entrypoints_*.deb
sudo apt-get install -f -y --force-yes

for PKG in `cat run_python_deb_pkgs.txt`;
do
    ./docker_scripts/build_python_deb.sh $PKG
done

./docker_scripts/build_coin.sh
./docker_scripts/build_fit2tcx.sh

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
