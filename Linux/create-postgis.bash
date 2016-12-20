#! /bin/bash

su - postgres -c \
  "psql -d ${1} -c 'CREATE EXTENSION postgis;'"
