#! /bin/bash

wget https://github.com/hackoregon/postgis-geocoder-test/releases/download/v1.5.0/geocoder.pgdump
sudo su postgres -c "pg_restore -C -d postgres geocoder.pgdump"

