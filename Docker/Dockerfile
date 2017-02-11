FROM docker.io/postgres:latest
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# Install PostGIS
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  postgis \
  unzip \
  wget \
  && apt-get clean

# Load scripts for geocoder database build
RUN mkdir -p /gisdata/temp
COPY 1create-geocoder-database.bash /gisdata/
COPY 2make-geocoder-download-scripts.bash /gisdata/
COPY extensions.sql /gisdata/
COPY make-tiger-scripts.psql /gisdata/
RUN chmod +x /gisdata/*.bash
RUN chown -R postgres:postgres /gisdata/
