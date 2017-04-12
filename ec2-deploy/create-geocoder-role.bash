#! /bin/bash

export COMMAND="createuser"
export OPTIONS="--no-createdb --login --no-createrole --no-superuser --no-replication --interactive --pwprompt"
sudo su postgres -c  "$COMMAND $OPTIONS"
echo "Testing the role"
read -p "Enter name of role you just added: " ROLE
psql -d geocoder -h localhost -U $ROLE -f test-geocoder.sql
