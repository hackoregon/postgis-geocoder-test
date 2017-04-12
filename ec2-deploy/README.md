# Hack Oregon Geocoder Spring 2017 Edition

## Building the database
1. You'll need a 64-bit Ubuntu 16.04.2 LTS "Xenial Xerus" base box. I tested on a 15 GB drive but it looks like it will run in 10. It will need at least 10. I tested on a 1 GB RAM local VM and a 1 GB RAM EC2 instance.
2. You'll need `git` and `sudo` but the scripts should install everything else required.
3. Log in on a terminal via `ssh` - don't do this on the console in a VM.
4. Enter

    ```
    git clone https://github.com/hackoregon/postgis-geocoder-test
    cd postgis-geocoder-test/ec2-deploy
    sudo ./root-install-postgis.bash
    ```

    The script will take about half an hour ... it downloades a bunch of shapefiles, inserts them into a database, builds some indexes, creates a `pg_dump` of the database and makes an HTML database document. The last thing it does is test the geocoder. If everything worked you'll see the Hack Oregon headquarters geocoded.
5. The dump file is in `/gisdata/geocoder.pgdump` and the HTML document is in `/gisdata/geocoder.html`. You should be able to recreate this on any PostgreSQL 9.6 / PostGIS 2.3 system by restoring the dump file as the `postgres` PostgreSQL superuser. The command is 

    ```
    sudo su postgres -c "pg_restore -C -d postgres geocoder.pgdump
    ```

## Adding a non-privileged user
To execute queries against the geocoder, you need to create a non-privileged database role, and that role has to have a password. The script `create-geocoder-role.bash` does this. You need to execute this as a user authorized to use `sudo`.

    ```
    cd postgis-geocoder-test/ec2-deploy
    ./create-geocoder-role.bash
    ```

The result will look like this:

    ```
    $ ./create-geocoder-role.bash 
    Enter name of role to add: buckborasky
    Enter password for new role: 
    Enter it again: 
    Testing the role
    Enter name of role you just added: buckborasky
    Password for user buckborasky: 
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
