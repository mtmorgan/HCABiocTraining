#!/bin/bash

# copied from https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/experimental/install_rl.sh

set -e

python3 -m venv /opt/venv/anndata
. /opt/venv/anndata/bin/activate

pip3 install wheel
pip3 install anndata

chown -R :staff /opt/venv/anndata
chmod g+rx /opt/venv/anndata
