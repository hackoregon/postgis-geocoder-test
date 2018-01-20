#! /bin/bash

# assumes the PostGIS container is running on 'docker_postgis_1'
# build the database and dump it - takes a while!
echo "Sleeping 30 seconds to wait for PostGIS to start."
echo "The database load / dump creation will take off after that and will run for some time."
sleep 30 # wait for the service to come up
docker exec docker_postgis_1 /start-creation.bash

# save the image with the geocoder dump on it
echo "Committing the postgis-with-dump image"
docker commit docker_postgis_1 docker.io/znmeb/postgis-with-dump
