#! /bin/bash

echo "Creating a geocoder database"
createdb -O postgres geocoder
psql -d geocoder -f extensions.sql

# make workspace
echo "Creating the /gisdata workspace"
mkdir -p /gisdata/temp
chown -R ${USER}:${USER} /gisdata

# execute script builder
echo "Creating the database population scripts"
for i in nation oregon
do
  psql -d geocoder -f make-$i-script.psql
  pushd /gisdata
  sed -i -e '/PGHOST/d' $i.bash
  chmod +x $i.bash
  ./$i.bash
  popd
done

echo "Installing any missing indexes"
psql -d geocoder -c "SELECT install_missing_indexes();"
echo "Creating a dump of the geocoder database"
pg_dump -Fc geocoder > /gisdata/geocoder.pgdump

echo "Testing the geocoder - compare lon and lat with Google Maps"
psql -d geocoder -f test-geocoder.sql
