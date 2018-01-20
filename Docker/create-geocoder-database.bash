#! /bin/bash

cd /home/postgres # just in case we got lost coming in

echo "Creating a geocoder database"
createdb -O postgres geocoder
psql -d geocoder -f extensions.sql

echo "Creating the /gisdata workspace"
mkdir -p /gisdata/temp
chown -R ${USER}:${USER} /gisdata

echo "Populating the database - this will take some time."
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

./test-geocoder.bash
