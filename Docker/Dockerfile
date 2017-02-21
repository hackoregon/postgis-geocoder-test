FROM docker.io/postgres:9.6
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# Install PostGIS and utilities
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  ca-certificates \
  postgresql-9.6-postgis-2.3 \
  postgresql-9.6-postgis-2.3-scripts \
  wget \
  && apt-get clean

# Grab geocoder dump file
RUN mkdir -p /gisdata
WORKDIR /gisdata
RUN wget https://github.com/hackoregon/postgis-geocoder-test/releases/download/testing/geocoder.pgdump

# set up entry point to restore the geocoder
RUN mkdir -p /docker-entrypoint-initdb.d
COPY restore-geocoder.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/restore-geocoder.sh
