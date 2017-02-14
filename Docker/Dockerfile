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
COPY prefetch.bash /gisdata/
COPY create-geocoder-database.bash /gisdata/
COPY extensions.sql /gisdata/
COPY make-tiger-scripts.psql /gisdata/
RUN chmod +x /gisdata/*.bash
RUN chown -R postgres:postgres /gisdata/

# Copy startup script to /docker-entrypoint-initdb.d
RUN mkdir -p /docker-entrypoint-initdb.d
COPY startup.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/startup.sh

# Run prefetch now - doesn't need PostgreSQL service
WORKDIR /gisdata
USER postgres
RUN /gisdata/prefetch.bash

# Now populate the database
RUN mkdir -p /var/lib/hackoregon
ENV PGDATA /var/lib/hackoregon
RUN pg_ctl init \
  && pg_ctl start \
  && psql -c "ALTER ROLE postgres WITH PASSWORD 'yourpasswordhere';" \
  && /gisdata/create-geocoder-database.bash \
  && pg_ctl stop
