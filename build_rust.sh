#!/bin/bash

cd ~/docker_scripts/rust_nightly

make && make push

docker rmi `docker images | awk '/rust_nightly/' | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`

cd ~/docker_scripts/rust_stable

make amazon && make push_amazon

docker rmi `docker images | awk '/rust_stable/ && /amazon/' | python -c "import sys; print('\n'.join(l.split()[2] for l in sys.stdin if '<none>' in l))"`

make && make push

cd ~/

sudo rm -rf ~/docker_scripts
