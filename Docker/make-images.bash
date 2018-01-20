#! /bin/bash

echo "Building the vanilla 'postgis' image."
docker-compose -f postgis.yml build

echo "Building the 'postgis-geocoder' image."
echo "This will also build the geocoder database onto a persistent host volume."
docker-compose -f postgis-geocoder.yml build
