#! /bin/bash

echo "Shutting down the services"
docker-compose -f postgis-geocoder.yml down
