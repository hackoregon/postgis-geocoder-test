
#! /bin/bash

echo "Creating a PostGIS template and geocoder database"
echo "If you've already created the geocoder database you can ignore the error messages."
createdb -O postgres postgis_template
psql -d postgis_template -f extensions.sql
createdb -O postgres geocoder -T postgis_template

# execute script builder
psql -d geocoder -f make-tiger-scripts.psql
chmod +x /gisdata/nation.bash
chmod +x /gisdata/oregon.bash
./nation.bash
./oregon.bash
pg_dump -Fc geocoder > geocoder.pgdump
