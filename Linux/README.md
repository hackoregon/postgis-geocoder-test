# Setting up PostGIS

The current setup is for [Fedora Linux 25](https://fedoraproject.org/). It should work on other distros with the following dependencies:

1. You need PostgreSQL and PostGIS. You do *not* need any header files.
2. On Debian / Ubuntu installing PostgreSQL creates a database data area and enables / starts the service. On Fedora, you need to do these things after the install.

Note that with PostgreSQL on Linux, there are two sets of users, Linux users and PostgreSQL database users, often called 'roles' in PostgreSQL jargon. For most desktop installations, things are easier if they are mapped one-to-one. That is, the PostgreSQL role 'znmeb' is the same person as the Linux user 'znmeb'.

When PostgreSQL is installed and configured, there will be a 'postgres' Linux user. And there will be a 'postgres' database role (user) inside the PostgreSQL database. This database user has 'superuser' powers - it can create other users and in general mess with stuff inside PostgreSQL just like 'root' can on a Linux system.

1. Configure PostgreSQL
      ```
      ./1configure-postgresql.bash
      ```
      This creates the PostgreSQL data area on the hard drive, enables the PostgreSQL server to start at boot time, starts it and installs the 'adminpack' extension. It will ask you to create a password for the PostgreSQL 'superuser', named 'postgres'. You only have to run this once, but it won't hurt anything if you run it again.

2. Set up the PostGIS databases
      ```
      ./2set-up-postgis.bash
      ```
      This will create a _non-superuser_ PostgreSQL role/user with the same name as your Fedora Linux login. If the role/user exists already, it will be deleted and recreated. Then it will create a `geocoder` database for that user.

3. Download the TIGER geocoder data. This is a two-step process. For more details, see [_PostGIS in Action, Second Edition_](http://www.manning.com/obe2/).
	```
	./3make-geocoder-download-scripts.bash
	```
	This executes some code in the PostGIS package to create two scripts in `/gisdata`. One script, called 'state-county.bash', downloads nationwide state and county shapefiles. The second, called 'oregon.bash', downloads detailed shapefiles for Oregon.

	After the scripts are generated, do the following:
	```
	sudo su - postgres
	cd /gisdata
	```
	This puts you into the PostgreSQL _Linux_ maintenance account. The scripts require this 'superuser' privilege to run.

	Run the scripts.
	```
	./state-county.bash
	./oregon-washington.bash
	```
	They will run longer the first time while downloading the raw data from the TIGER FTP site. Later ones will only download changed ZIP archives.
