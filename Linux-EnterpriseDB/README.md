After a good bit of thrashing around and a PostGIS geocoder bug and a download blacklist, I have this working on my Fedora 25 workstation. This should work on any recent Linux.

## Why EnterpriseDB PostgreSQL?
All the Linux distros come with PostgreSQL, and they all have upstream repositories where you can get the most recent version of PostgreSQL, so why EnterpriseDB? Two reasons, really:

1. The standard libraries for PostgreSQL may already be installed, and things are set up to use them, possibly without your knowledge. Messing with them in any way will mess up your system. To use the 2016 TIGER/Line data, we need PostgreSQL 9.6 and PostGIS 2.3, not whatever happened to be stable when the distro was released.

    EnterpriseDB PostgreSQL installs itself in `/opt` and doesn't mess with your paths. It sees any existing PostgreSQL and uses a different port, in my case 5433.
2. EnterpriseDB ships with a ***working*** copy of PgAdmin4. I haven't found any packaged RPM or DEB for PgAdmin4 that works.

## How to do it
1. Install EnterpriseDB's 9.6 release for Linux and the PostGIS 2.3 spatial extension.
2. Edit `env-enterprisedb` to get the right values for your installation. Note that the EnterpriseDB `postgres` password needs to be set in your `~/.pgpass` file for this stuff to work.
3. Run `create-geocoder-database.bash`. This will create the `geocoder` database and set everything up for the next step.
4. Type `sudo su - postgres` and `cd /gisdata`.
5. Edit `nation.bash` and `oregon.bash`. You will need to change PGPORT to the port EnterpriseDB PostgreSQL is using, and you will need to change `PGPASSWORD` to the `postgres` password you set when you installed EnterpriseDB PostgreSQL.
6. `./prefetch-pdx.bash`. This will fetch the TIGER/Line shapefiles for the nation, the state of Oregon and Multnomah, Washington and Clackamas counties. It will also make a ZIP archive, `prefetch-pdx.zip`, with the shapefiles in it. We need this for two reasons:

    1. There is a bug in the PostGIS script generator for states; this is what generated the `oregon.bash` script. Specifically, some `wget` commands to download shapefiles are missing.
    2. If you hit the TIGER/Line download site often / hard enough, it will blacklist you. In my case, on my workstation, the host still works but guest Docker containers or virtual machines appear to be blacklisted now.
7. `./nation.bash` and then `./oregon.bash`. These scripts populate the tables in the `geocoder` database from the shapefiles.
8. `exit`. Now you should be back in this directory.
9. `./post-processing.bash`. This does three things:

    1. Builds indexes in the `geocoder` database.
    2. Does a `pg_dump` of the `geocoder` database to `/gisdata/geocoder.pgdump`. You can make a geocoder on another PostgreSQL 9.6 / PostGIS 2.3 installation simply by restoring this file with `pg_restore`.
    3. Tests the geocoder on Hack Oregon's street address.
