#! /bin/bash

# connection environment variables
source env-enterprisedb

echo "Creating a geocoder database"
echo "If you've already created the geocoder database you can ignore the error messages."
createdb -O postgres geocoder
psql -d geocoder -f extensions.sql

# make workspace
echo "Creating the /gisdata workspace"
sudo mkdir -p /gisdata/temp
sudo chown -R ${USER}:${USER} /gisdata

# execute script builder
echo "Creating the database population scripts"
echo "You will need to edit them to change port and password"
psql -d geocoder -f make-tiger-scripts.psql
for i in nation oregon
do
  sed -i -e 's;PGBIN=.*$;PGBIN=/opt/PostgreSQL/9.6/bin;' /gisdata/$i.bash
done
cp prefetch-pdx.bash /gisdata
chmod +x /gisdata/*.bash

# change owner to 'postgres' - the generated scripts have to run as 'postgres'
echo "Changing the workspace owner to 'postgres'"
sudo chown -R postgres:postgres /gisdata

echo "Ready for next steps:"
echo "1. sudo su - postgres"
echo "2. cd /gisdata"
echo "3. edit 'nation.bash' and 'oregon.bash' to set port and 'postgres' password"
echo "4. ./prefetch-pdx.bash"
echo "5. ./nation.bash"
echo "6. ./oregon.bash"
echo "7. exit"
echo "8. Return here and run './post-processing.bash'"
