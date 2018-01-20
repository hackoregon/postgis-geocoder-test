#! /bin/bash

echo "Bringing up the 'postgis' service."
docker-compose -f postgis.yml up --build -d

# build the database and dump it if needed - takes a while!
if [ ! -e /data/gisdata/geocoder.pgdump ]
then
  echo "Creating the 'gisdata' host volume."
  sudo rm -fr /data/gisdata
  sudo mkdir -p /data/gisdata
  sudo chown 999:999 /data/gisdata
  echo "Sleeping 30 seconds to wait for PostGIS to start."
  echo "The database load / dump creation will take off after that and will run for some time."
  sleep 30
  docker exec docker_postgis_1 /start-creation.bash
else
  echo "The database dump file already exists."
fi

# we don't need the 'postgis' service any more
echo "Bringing down the 'postgis' service."
docker-compose -f postgis.yml down

# copy dump here
cp /data/gisdata/geocoder.pgdump .

echo "Bringing up the 'postgis-geocoder' service."
docker-compose -f postgis-geocoder.yml up --build
