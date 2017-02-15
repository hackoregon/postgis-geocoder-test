#! /bin/bash

source env-enterprisedb

# make workspace
sudo rm -fr /gisdata/temp
sudo mkdir -p /gisdata/temp
sudo chown -R ${USER}:${USER} /gisdata

# execute script builder
psql -d geocoder -f make-tiger-scripts.psql
chmod +x /gisdata/*.bash

# change owner to 'postgres' - the generated scripts have to run as 'postgres'
sudo chown -R postgres:postgres /gisdata
