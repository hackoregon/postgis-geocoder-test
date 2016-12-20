#! /bin/bash

sudo postgresql-setup initdb # fails harmlessly if data directory isn't empty
sudo systemctl enable postgresql # start the server on reboot
sudo systemctl start postgresql # start the server now

# password protect the PostgreSQL superuser, 'postgres'
echo "Create a password for 'postgres', the PostgreSQL superuser"
sudo su - postgres -c "psql -c '\password postgres'"

# install the extensions - will ERROR harmlessly if they're already there
sudo su - postgres -c "psql -c 'CREATE EXTENSION adminpack;'"
sudo su - postgres -c \
  "psql -c 'CREATE EXTENSION plpgsql WITH SCHEMA pg_catalog;'"
