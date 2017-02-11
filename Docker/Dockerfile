FROM docker.io/postgres:latest
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# Install PostGIS and utilities
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  postgis \
  postgresql-9.6-pgrouting \
  postgresql-9.6-pgrouting-scripts \
  postgresql-9.6-postgis-2.3 \
  postgresql-9.6-postgis-2.3-scripts \
  unzip \
  wget \
  && apt-get clean

# Copy scripts for geocoder database build to /gisdata
RUN mkdir -p /gisdata/temp
COPY 0prefetch.bash /gisdata/
COPY create-geocoder-database.bash /gisdata/
COPY extensions.sql /gisdata/
COPY make-tiger-scripts.psql /gisdata/
RUN chmod +x /gisdata/*.bash
RUN chown -R postgres:postgres /gisdata/
