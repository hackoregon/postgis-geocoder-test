#! /bin/bash

# make workspace
sudo rm -fr /gisdata/temp
sudo mkdir -p /gisdata/temp
sudo chown -R ${USER}:${USER} /gisdata

# execute script builder
psql -f make-tiger-scripts.psql geocoder znmeb
chmod +x /gisdata/*.bash

# fix path
for i in '/gisdata/state-county.bash' '/gisdata/oregon.bash'
do
  sed -i 's;export PGBIN=.*$;export PGBIN=/usr/bin;' ${i}
done

# comment out 'localhost' setting so we can use UNIX sockets
for i in '/gisdata/state-county.bash' '/gisdata/oregon.bash'
do
  sed -i 's;export PGHOST=localhost;#export PGHOST=localhost;' ${i}
done

# change owner to 'postgres' - the generated scripts have to run as 'postgres'
sudo chown -R postgres:postgres /gisdata
