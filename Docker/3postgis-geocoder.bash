#! /bin/bash

# create and start the PostGIS image with geocoder database
echo "Building the Docker PostGIS geocoder image"
docker-compose -f postgis-geocoder.yml up --build -d

# wait 60 seconds and then test
echo "Sleeping 60 seconds to wait for service to start"
sleep 60
echo "Testing the geocoder - compare lon and lat with Google Maps"
docker exec --user postgres docker_postgis-geocoder_1 "psql -d geocoder -f test-geocoder.sql"
