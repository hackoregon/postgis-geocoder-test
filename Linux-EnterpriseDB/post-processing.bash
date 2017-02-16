#! /bin/bash

source env-enterprisedb
sudo chown -R ${USER}:${USER} /gisdata

psql -d geocoder -c "SELECT install_missing_indexes();"
pg_dump -Fc geocoder > /gisdata/geocoder.pgdump
