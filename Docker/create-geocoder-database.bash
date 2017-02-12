#! /bin/bash

echo "Creating a geocoder database"
echo "If you've already created the geocoder database you can ignore the error messages."
createdb -O postgres geocoder
psql -d geocoder -f extensions.sql

# execute script builder
psql -d geocoder -f make-tiger-scripts.psql
chmod +x /gisdata/nation.bash
chmod +x /gisdata/oregon.bash
./nation.bash
./oregon.bash
pg_dump -Fc geocoder > geocoder.pgdump
