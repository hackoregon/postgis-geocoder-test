FROM docker.io/znmeb/postgis
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# copy in startup script
RUN mkdir -p /docker-entrypoint-initdb.d/
COPY start-creation.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/*sh

# copy in scripts that run as 'postgres'
COPY *sql /home/postgres/
COPY create-geocoder-database.bash /home/postgres/
COPY test-geocoder.bash /home/postgres/
RUN chown -R postgres:postgres /home/postgres/
