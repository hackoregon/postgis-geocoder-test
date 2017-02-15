#! /bin/bash

source env-enterprisedb

psql -d geocoder -c "SELECT install_missing_indexes();"
