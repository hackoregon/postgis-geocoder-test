#! /bin/bash

createdb -O postgres geocoder
psql -d geocoder < create-extensions.sql
psql -d geocoder < generate-nation.psql
psql -d geocoder < generate-oregon.psql
