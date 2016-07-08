#!/bin/bash

rm ~/setup_files/deb/py2deb/solver_python/python-mvpd-pronto_*.deb
mv ~/py2deb/python-mvpd-pronto_*.deb ~/setup_files/deb/py2deb/solver_python/
~/setup_files/build/ddboline_personal_scripts/setup_python_repo.sh
