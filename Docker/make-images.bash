#! /bin/bash

echo "Building the vanilla 'postgis' image."
docker-compose -f postgis.yml build

echo "Building the 'postgis-geocoder' image."
docker-compose -f postgis-geocoder.yml build

echo "Starting the 'postgis-geocoder' service."
docker-compose -f postgis-geocoder.yml up
