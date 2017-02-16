#! /bin/bash

source env-enterprisedb
sudo chown -R ${USER}:${USER} /gisdata

echo "Installing any missing indexes"
psql -d geocoder -c "SELECT install_missing_indexes();"
echo "Creating a dump of the geocoder database"
pg_dump -Fc geocoder > /gisdata/geocoder.pgdump

echo "Testing the geocoder - compare lon and lat with Google Maps"
psql -d geocoder -f test-geocoder.sql
