#! /bin/bash

# connection environment variables
source env-enterprisedb

echo "Creating a geocoder database"
echo "If you've already created the geocoder database you can ignore the error messages."
createdb -O postgres geocoder
psql -d geocoder -f extensions.sql

# make workspace
sudo rm -fr /gisdata/temp
sudo mkdir -p /gisdata/temp
sudo chown -R ${USER}:${USER} /gisdata

# execute script builder
psql -d geocoder -f make-tiger-scripts.psql
for i in nation oregon
do
  sed -i -e 's;PGBIN=.*$;PGBIN=/opt/PostgreSQL/9.6/bin;' /gisdata/$i.bash
  sed -i -e 's;PGPORT=.*$;PGPORT=5433;' /gisdata/$i.bash
done
chmod +x /gisdata/*.bash
cp prefetch-pdx.bash /gisdata
cp install-missing-indexes.bash /gisdata

# change owner to 'postgres' - the generated scripts have to run as 'postgres'
sudo chown -R postgres:postgres /gisdata
