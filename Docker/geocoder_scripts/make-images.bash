#! /bin/bash

echo "Building the vanilla 'postgis' image."
docker-compose -f postgis.yml build

echo "Building the 'postgis-geocoder' image."
docker-compose -f postgis-geocoder.yml build

echo "Bringing the 'postgis-geocoder' service up."
docker-compose -f postgis-geocoder.yml up

echo "Shutting the 'postgis-geocoder' service down."
docker-compose -f postgis-geocoder.yml down
