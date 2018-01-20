#! /bin/bash

# create the empty PostGIS image and start it - resulting image is 458 MB as of 2018-01-19
docker-compose -f postgis_image.yml up --build -d
