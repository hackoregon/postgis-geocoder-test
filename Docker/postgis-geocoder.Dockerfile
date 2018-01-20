FROM docker.io/znmeb/postgis
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# copy in scripts that run as 'postgres'
COPY *sql /home/postgres/
COPY create-geocoder-database.bash /home/postgres/
COPY test-geocoder.bash /home/postgres/
RUN chown -R postgres:postgres /home/postgres/

# populate the database
USER postgres
WORKDIR /home/postgres/
RUN /home/postgres/create-geocoder-database.bash
