#! /bin/bash

# make workspace
sudo rm -fr /gisdata/temp
sudo mkdir -p /gisdata/temp
sudo chown -R ${USER}:${USER} /gisdata

# execute script builder
psql -h localhost -f make-tiger-scripts.psql postgres postgres
chmod +x /gisdata/*.bash

# edit the scripts
for i in '/gisdata/nation.bash' '/gisdata/oregon.bash'
do
  sed -i 's;export PGBIN=.*$;export PGBIN=/usr/bin;' ${i}
  sed -i 's;export PGDATABASE=.*$;export PGDATABASE=postgres;' ${i}
  sed -i 's;export PGPASSWORD;#export PGPASSWORD;' ${i}
  sed -i 's;export PGHOST;#export PGHOST;' ${i}
done

# change owner to 'postgres' - the generated scripts have to run as 'postgres'
sudo chown -R postgres:postgres /gisdata
