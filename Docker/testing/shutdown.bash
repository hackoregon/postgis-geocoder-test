#! /bin/bash

# create the empty PostGIS image and start it - resulting image is 467 MB as of 2018-01-19
echo "Shutting down the services"
docker-compose -f postgis.yml -f postgis-geocoder.yml down
