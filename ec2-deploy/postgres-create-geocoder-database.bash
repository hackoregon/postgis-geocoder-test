#! /bin/bash

echo "Creating 'geocoder' database."
echo "If there's already a 'geocoder' database you can ignore the error message."
createdb -O postgres geocoder
echo ""
echo "Creating geocoder extension"
echo "If you've already created the extension you can ignore the error messages."
psql -d geocoder -f extensions.sql

echo ""
echo "Creating the nation database population script"
psql -d geocoder -f make-nation-script.psql
chmod +x /gisdata/nation.bash
sed -i -e "s;PGHOST=.*$;PGHOST=/var/run/postgresql;" /gisdata/nation.bash
echo "Running the nation database population script"
/gisdata/nation.bash

echo ""
echo "Creating the states database population script"
psql -d geocoder -f make-states-script.psql
chmod +x /gisdata/states.bash
sed -i -e "s;PGHOST=.*$;PGHOST=/var/run/postgresql;" /gisdata/states.bash
echo "Running the states database population script"
/gisdata/states.bash

echo ""
echo "Installing any missing indexes"
psql -d geocoder -c "SELECT install_missing_indexes();"

echo ""
echo "Creating a dump of the geocoder database"
pg_dump -Fc geocoder > /gisdata/geocoder.pgdump

echo ""
echo "Creating a zipfile of the TIGER/Line shapefiles"
zip -9r /gisdata/shapefiles.zip /gisdata/www2.census.gov/

echo ""
echo "Testing the geocoder - compare lon and lat with Google Maps"
psql -d geocoder -f test-geocoder.sql

echo ""
echo "Documenting geocoder database schema"
postgresql_autodoc -d geocoder -f /gisdata/geocoder -h /var/run/postgresql -t html
