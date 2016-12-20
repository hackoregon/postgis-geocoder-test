#! /bin/bash

su - postgres -c \
  "psql -d ${1} -c 'CREATE EXTENSION fuzzystrmatch;'"
su - postgres -c \
  "psql -d ${1} -c 'CREATE EXTENSION postgis_tiger_geocoder;'"
su - postgres -c \
  "psql -d ${1} -c 'GRANT USAGE ON SCHEMA tiger TO PUBLIC;'"
su - postgres -c \
  "psql -d ${1} -c 'GRANT USAGE ON SCHEMA tiger_data TO PUBLIC;'"
su - postgres -c \
  "psql -d ${1} -c 'GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA tiger TO PUBLIC;'"
su - postgres -c \
  "psql -d ${1} -c 'GRANT SELECT, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA tiger_data TO PUBLIC;'"
su - postgres -c \
  "psql -d ${1} -c 'GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA tiger TO PUBLIC;'"
su - postgres -c \
  "psql -d ${1} -c 'ALTER DEFAULT PRIVILEGES IN SCHEMA tiger_data GRANT SELECT, REFERENCES ON TABLES TO PUBLIC;'"
