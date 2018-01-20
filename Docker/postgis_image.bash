#! /bin/bash

# create the empty PostGIS image and start it - resulting image is 458 MB as of 2018-01-19
echo "Building the Docker PostGIS image"
docker-compose -f postgis_image.yml up --build -d

# build the database and dump it - takes a while!
echo "Sleeping 30 seconds to wait for PostGIS to start."
echo "The database load will take off after that and will run for some time."
sleep 30 # wait for the service to come up
docker exec docker_postgis_1 /start-creation.bash
