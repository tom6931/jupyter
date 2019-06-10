#!/bin/bash
# setup.sh: Set up environment for a Ubuntu system
#
# Author: Christiam Camacho (camacho@ncbi.nlm.nih.gov)
# Created: Mon 10 Jun 2019 12:36:52 PM EDT

export PATH=/bin:/usr/bin
set -euo pipefail
shopt -s nullglob

sudo apt update
sudo snap install docker
sudo apt install -y docker.io virtualenv
sudo usermod -aG docker $USER

echo "#####################################"
echo "### Please logout and log back in ###"
echo "#####################################"
