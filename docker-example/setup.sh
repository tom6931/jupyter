#!/bin/bash
# setup.sh: What this script does
#
# Author: Christiam Camacho (camacho@ncbi.nlm.nih.gov)
# Created: Mon 10 Jun 2019 12:36:52 PM EDT

export PATH=/bin:/usr/bin
set -euo pipefail
shopt -s nullglob

sudo apt update
sudo snap install docker
sudo apt install -y docker.io
sudo usermod -aG docker $USER

sudo apt install -y virtualenv

echo "Logout and log back in"
