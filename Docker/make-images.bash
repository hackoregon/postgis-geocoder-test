#! /bin/bash

# create an empty PostGIS image and start it - resulting image is 467 MB as of 2018-01-19
echo "Building the Docker PostGIS image."
docker-compose -f postgis.yml up --build -d

# assumes the PostGIS container is running on 'docker_postgis_1'
# build the database and dump it - takes a while!
if [ ! -e gisdata/geocoder.pgdump ]
then
  echo "Sleeping 30 seconds to wait for PostGIS to start."
  echo "The database load / dump creation will take off after that and will run for some time."
  sleep 30
  docker exec docker_postgis_1 /start-creation.bash
fi

# create and start the PostGIS image with geocoder database
echo "Building the Docker PostGIS geocoder image."
docker-compose -f postgis-geocoder.yml up --build -d

# wait 60 seconds and then test
echo "Sleeping 60 seconds to wait for service to start."
sleep 60
echo "Testing the geocoder - compare lon and lat with Google Maps."
docker exec --user postgres docker_postgis-geocoder_1 "/usr/bin/psql -d geocoder -f /home/postgres/test-geocoder.sql"
