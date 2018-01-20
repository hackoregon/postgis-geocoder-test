#! /bin/bash

# build the database and dump it if needed - takes a while!
if [ ! -e /data/gisdata/geocoder.pgdump ]
then
  echo "Creating the 'gisdata' host volume."
  sudo rm -fr /data/gisdata
  sudo mkdir -p /data/gisdata
  sudo chown 999:999 /data/gisdata
  echo "Building the 'postgis' image."
  docker-compose -f postgis.yml up --build -d
  echo "Sleeping 30 seconds to wait for PostGIS to start."
  echo "The database load / dump creation will take off after that and will run for some time."
  sleep 30
  docker exec docker_postgis_1 /start-creation.bash
else
  echo "The database dump file already exists."
fi

# copy dump here
cp /data/gisdata/geocoder.pgdump .

# create and start the postgis-geocoder image
echo "Building the 'postgis-geocoder' image."
docker-compose -f postgis-geocoder.yml up --build -d
