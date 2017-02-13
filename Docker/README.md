# Hack Oregon PostGIS Geocoder

## Docker hosting
I develop on a Fedora 25 host using `docker` and `docker-compose` as shipped in Fedora.

```
[znmeb@AlgoCompSynth Docker]$ docker --version
Docker version 1.12.6, build ae7d637/1.12.6
[znmeb@AlgoCompSynth Docker]$ docker-compose --version
docker-compose version 1.9.0, build 2585387
```

I test on Windows 10 Pro using Docker for Windows. This is the Docker package that uses the native Hyper-V virtualizer, *not* the one that uses VirtualBox. If you have another Docker hosting setup make sure it's at least Docker 1.12.6 and docker-compose 1.9.0, and open an issue if anything is broken.

## Usage
There are two phases to creating this image. The first phase happens on Docker Hub with an automated build. That creates an image, [docker.io/znmeb/postgis_geocoder]([https://hub.docker.com/r/znmeb/postgis_geocoder/). This image contains:

1. The complete official PostgreSQL image (PostgreSQL 9.6 on a Debian base),
2. PostGIS and PgRouting 2.3, and
3. The raw shapefiles from the Census Bureau TIGER/Line site for 2016 used to populate the geocoder tables.

As built, the image contains the code and input data but is not active and usable as a server. To finish the build, you have to download the image to your Docker host and run a script to populate the database.

### Populating the database
1. Download the image: `docker pull docker.io/znmeb/postgis_geocoder`.
2. Important! Set the environment variable POSTGRES_PASSWORD to "yourpasswordhere". The activation process sets this password for the `postgres` database superuser, and the database population scripts have that hard coded. Once you've populated the database you can change the password.
3. Do `docker run --detach --name postgis_geocoder docker.io/znmeb/postgis_geocoder /bin/bash`. This will put you in a console inside the `postgis_geocoder` container. You'll be logged in as `postgres` in the `/gisdata` directory.
4. Type `/gisdata/create-geocoder-database.bash`. This will build the `geocoder` database.
5. Type `exit` to leave the console after the script has finished. Then type

```
docker pause postgis_geocoder
docker commit postgis_geocoder postgis_geocoder_populated
docker unpause postgis_geocoder
docker stop postgis_geocoder
```

The image is now ready for use.
