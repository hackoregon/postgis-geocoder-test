FROM docker.io/postgres:10
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# Install PostGIS and utilities
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
  ca-certificates \
  postgis \
  postgresql-10-postgis-2.4 \
  postgresql-10-postgis-2.4-scripts \
  postgresql-10-postgis-scripts \
  postgresql-10-pgrouting \
  postgresql-10-pgrouting-scripts \
  unzip \
  wget \
  && apt-get clean

RUN mkdir -p /home/postgres/
RUN usermod --shell /bin/bash postgres
COPY *sql /home/postgres/
COPY create-geocoder-database.bash /home/postgres/
RUN chown -R postgres:postgres /home/postgres/
