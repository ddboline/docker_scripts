#!/bin/bash

REPO="$@"

CONDA=`which conda`

sudo $CONDA install conda-build
$CONDA skeleton pypi $REPO
$CONDA build $REPO
