#! /bin/bash

sudo postgresql-setup --initdb --unit postgresql
# fails harmlessly if data directory isn't empty

sudo systemctl enable postgresql # start the server on reboot
sudo systemctl start postgresql # start the server now

# password protect the PostgreSQL superuser, 'postgres'
echo "Create a password for 'postgres', the PostgreSQL superuser"
sudo su - postgres -c "psql -c '\password postgres'"

# install the extensions - will ERROR harmlessly if they're already there
psql -d postgres -f extensions.sql
