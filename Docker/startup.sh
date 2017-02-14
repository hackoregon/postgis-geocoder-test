#! /bin/bash

# create geocoder database if it doesn't exist
pg_dump geocoder > /dev/null || /gisdata/create-geocoder-database.bash
