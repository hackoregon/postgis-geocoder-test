#! /bin/bash

export HERE=`pwd` # need absolute path later

# PostgreSQL username = Linux username
export PGUSER=${USER}

# drop the old databases if any
for i in \
  ${PGUSER} \
  geocoder
do
  sudo su - postgres -c "dropdb ${i}"
done

# drop and re-create the user
sudo su - postgres -c "dropuser ${PGUSER}"
sudo su - postgres -c "createuser -d ${PGUSER}"

# create databases for the user
for i in \
  ${PGUSER} \
  geocoder
do
  sudo su - postgres -c "createdb -O ${PGUSER} ${i}"
  sudo ${HERE}/create-postgis.bash ${i}
done

# create the TIGER extensions in 'geocoder'
sudo ${HERE}/create-tiger-schema.bash geocoder

echo "Create a password for the PostgreSQL user '${PGUSER}'"
psql -c '\password'
