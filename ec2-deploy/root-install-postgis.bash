#! /bin/bash

echo "Adding PostgreSQL / PostGIS package repository"
apt-get update && apt-get install -y \
  git \
  vim-nox \
  curl \
  wget \
  && apt-get clean
cp postgis.list /etc/apt/sources.list.d/
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc \
  | apt-key add -
apt-get update
echo "http://apt.postgresql.org/pub/repos/apt repository added!"
echo ""
echo "Installing PostGIS packages"
apt-get install -y \
  postgresql-9.6 \
  postgresql-autodoc \
  postgresql-client-9.6 \
  postgresql-contrib-9.6 \
  postgresql-doc-9.6 \
  postgresql-server-dev-9.6 \
  postgis \
  postgresql-9.6-postgis-2.3 \
  postgresql-9.6-postgis-2.3-scripts \
  postgresql-9.6-postgis-scripts \
  postgresql-9.6-pgrouting \
  postgresql-9.6-pgrouting-doc \
  postgresql-9.6-pgrouting-scripts \
  && apt-get clean

echo ""
echo "Creating the /gisdata workspace"
mkdir -p /gisdata/temp
chown -R postgres:postgres /gisdata

echo ""
echo "Populating the geocoder database - this will take a while"
su postgres -c ./postgres-create-geocoder-database.bash
