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
