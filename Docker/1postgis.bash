#! /bin/bash

# create the empty PostGIS image and start it - resulting image is 458 MB as of 2018-01-19
echo "Building the Docker PostGIS image"
docker-compose -f postgis.yml up --build -d
