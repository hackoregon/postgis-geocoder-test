# Hack Oregon Geocoder Spring 2017 Edition
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
5. The dump file is in `/gisdata/geocoder.pgdump` and the HTML document is in `/gisdata/geocoder.html`. You should be able to recreate this on any PostgreSQL 9.6 / PostGIS 2.3 system by restoring the dump file as the `postgres` PostgreSQL superuser.
