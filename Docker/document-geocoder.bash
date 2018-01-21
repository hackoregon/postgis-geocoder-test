#! /bin/bash

postgresql_autodoc -d geocoder -f geocoder -t html -u postgres -p 5439 -h localhost --password=$PGPASSWORD
