# Setting up PostGIS

The current setup is for [Fedora Linux 25](https://fedoraproject.org/). It should work on other distros with the following dependencies:

1. You need PostgreSQL, PostGIS and `pgrouting`. You do *not* need any header files.
2. On Debian / Ubuntu installing PostgreSQL creates a database data area and enables / starts the service. On Fedora, you need to do these things after the install.
3. Your Unix user ID must be mirrored in PostgreSQL and have PostgreSQL superuser privileges. This will be the case in the Hack Oregon virtual machine / Vagrant box.

Note that with PostgreSQL on Linux, there are two sets of users, Linux users and PostgreSQL database users, often called 'roles' in PostgreSQL jargon. For most desktop installations, things are easier if they are mapped one-to-one. That is, the PostgreSQL role `znmeb` is the same person as the Linux user `znmeb`.

When PostgreSQL is installed and configured, there will be a `postgres` Linux user. And there will be a `postgres` database role (user) inside the PostgreSQL database. This database user has superuser privileges - it can create other users and in general mess with stuff inside PostgreSQL just like `root` can on a Linux system.

1. Create `geocoder` database with owner `postgres`
      ```
      ./1create-geocoder-database.bash
      ```

2. Download the TIGER geocoder data. This is a two-step process. For more details, see [_PostGIS in Action, Second Edition_](http://www.manning.com/obe2/).
	```
	./2make-geocoder-download-scripts.bash
	```
	This executes some code in the PostGIS package to create two scripts in `/gisdata`. One script, called `nation.bash`, downloads nationwide state and county shapefiles. The second, called `oregon.bash`, downloads detailed shapefiles for Oregon.

	After the scripts are generated, do the following:
	```
	sudo su - postgres
	cd /gisdata
	```
	This puts you into the PostgreSQL _Linux_ maintenance account. The scripts require this superuser privilege to run.

	Run the scripts.
	```
	./nation.bash 2>&1 | tee nation.log
	./oregon.bash 2>&1 | tee oregon.log
	```
	They will run longer the first time while downloading the raw data from the TIGER FTP site. Later ones will only download changed ZIP archives.
