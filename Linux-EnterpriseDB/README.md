After a good bit of thrashing around and a PostGIS geocoder bug and a download blacklist, I have this working on my Fedora 25 workstation. This should work on any recent Linux.

## Why EnterpriseDB?
All the Linux distros come with PostgreSQL, and they all have upstream repositories where you can get the most recent version of PostgreSQL, so why EnterpriseDB? Two reasons, really:

1. The standard libraries for PostgreSQL may already be installed, and things are set up to use them, possibly without your knowledge. Messing with them in any way will mess up your system. To get the 2016 data, we need PostgreSQL 9.6 and PostGIS 2.3, not whatever happened to be stable when the release happened.

    EnterpriseDB installs itself in /opt and doesn't mess with your paths. It sees any existing PostgreSQL and uses a different port, in my case 5433.
2. EnterpriseDB ships with a *working* copy of PgAdmin4. I haven't found any packaged RPM or DEB for PgAdmin4 that works.

## How to do it
1. Install EnterpriseDB's 9.6 release for Linux and the PostGIS 2.3 spatial extension.
2. Edit `env-enterprisedb` to get the right values for your installation. Note that the EnterpriseDB `postgres` password needs to be set in your `~/.pgpass` file for this stuff to work.
3. Run `create-geocoder-database.bash`. This will make the database and set everything up for the next step.
