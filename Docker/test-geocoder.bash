#! /bin/bash

echo "Testing the geocoder - compare lon and lat with Google Maps"
psql -d geocoder -f /home/postgres/test-geocoder.sql
