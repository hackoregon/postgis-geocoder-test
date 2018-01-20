# Oregon Geocoder as a Docker image
1. You will need:
    * Docker Community Edition (stable): Docker version 17.03.1-ce, build c6d412e or later,
    * docker-compose: docker-compose version 1.11.2, build dfed245 or later, and
    * PostgreSQL 10 or greater on your host. This repository only uses `psql`, not the whole PostgreSQL package.
    * Note: I am currently testing on an Arch Linux system. I will be testing on Windows 10 Pro / Docker for Windows.
3. Open a command prompt in this directory and type `./make-images.bash`. It will take a while to restore the database. You can ignore errors and warnings.
4. When the service is ready you'll see something like

    ```
    postgis-geocoder_1  | 2018-01-20 11:10:01.039 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
    postgis-geocoder_1  | 2018-01-20 11:10:01.039 UTC [1] LOG:  listening on IPv6 address "::", port 5432
    postgis-geocoder_1  | 2018-01-20 11:10:01.062 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
    postgis-geocoder_1  | 2018-01-20 11:10:01.103 UTC [68] LOG:  database system was shut down at 2018-01-20 11:10:00 UTC
    postgis-geocoder_1  | 2018-01-20 11:10:01.118 UTC [1] LOG:  database system is ready to accept connections
    ```

    When those messages appear, type `CTRL-C` to stop the service. The container is now ready for re-use.
5. To start the service back up again, type `docker-compose -f postgis-geocoder.yml up -d`. The container will start up again and you'll be able to connect as `postgres` on host `localhost` port `5438` with the password you set above. Note that the port is ***5438*** to avoid conflicts with your host PostgreSQL service.
6. Testing: type

    ```
    source env-postgis-geocoder
    ./test-geocoder.bash
    ```

    You'll see the old Hack Oregon headquarters geocoded!

    ```
    Testing the geocoder - compare lon and lat with Google Maps
     r |        lon        |       lat        |               paddress               
    ---+-------------------+------------------+--------------------------------------
     0 | -122.673675308776 | 45.5268939017685 | 317 NW Glisan St, Portland, OR 97209
    (1 row)

                 pprint_addy              |          st_astext           | rating 
    --------------------------------------+------------------------------+--------
     300 NW Glisan St, Portland, OR 97209 | POINT(-122.673521 45.526673) |      6
     NW Glisan St, Portland, OR           | POINT(-122.673521 45.526673) |      6
     300 NW Glisan St, Portland, OR 97209 | POINT(-122.67353 45.526838)  |     14
     301 NW Glisan St, Portland, OR 97209 | POINT(-122.67353 45.526838)  |     14
     298 NW Glisan St, Portland, OR 97209 | POINT(-122.67353 45.526838)  |     14
     299 NW Glisan St, Portland, OR 97209 | POINT(-122.67353 45.526838)  |     14
    (6 rows)
    ```
