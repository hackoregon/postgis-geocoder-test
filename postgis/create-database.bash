#! /bin/bash

createdb -O postgres geocoder
psql -d geocoder < create-extensions.sql
psql -c "SELECT loader_generate_nation_script(’sh’);" -d geocoder -tA > /gisdata/nation.sh
psql -c "SELECT loader_generate_script(ARRAY[’OR’], 'sh')" -d geocoder -tA > /gisdata/oregon.sh
