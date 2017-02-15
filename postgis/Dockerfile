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

# Create path for shapefiles
RUN mkdir -p /gisdata/temp

# Load scripts into /gisdata
COPY create-extensions.sql /gisdata/
COPY generate-nation.psql /gisdata/
COPY generate-oregon.psql /gisdata/
COPY create-database.bash /gisdata/

# Set USER and WORKDIR
RUN chmod +x /gisdata/*.bash
RUN chown -R postgres:postgres /gisdata
USER postgres
WORKDIR /gisdata
