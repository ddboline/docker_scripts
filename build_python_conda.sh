#!/bin/bash

### Why the f*** does this matter at all?
export LANG="C.UTF-8"

REPO="$@"

CONDA=`which conda`

sudo $CONDA install conda-build
$CONDA skeleton pypi $REPO
$CONDA build $REPO
