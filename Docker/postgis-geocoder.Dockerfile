FROM docker.io/znmeb/postgis
MAINTAINER M. Edward (Ed) Borasky <znmeb@znmeb.net>

# copy the database dump in
COPY geocoder.pgdump /

# set up entry point to restore the geocoder
RUN mkdir -p /docker-entrypoint-initdb.d
COPY restore-geocoder.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/restore-geocoder.sh
