#! /bin/bash

# create geocoder database if it doesn't exist
if [ -e "/gisdata/geocoder.pgdump" ]
then
  pg_restore /gisdata/geocoder.pgdump
else
  /gisdata/create-geocoder-database.bash
fi
