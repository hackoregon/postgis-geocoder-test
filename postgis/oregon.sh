TMPDIR="/gisdata/temp/"
UNZIPTOOL=unzip
WGETTOOL="/usr/bin/wget"
export PGBIN=/usr/lib/postgresql/9.6/bin
export PGPORT=5432
export PGHOST=localhost
export PGUSER=postgres
export PGPASSWORD=yourpasswordhere
export PGDATABASE=geocoder
PSQL=${PGBIN}/psql
SHP2PGSQL=shp2pgsql
cd /gisdata

cd /gisdata
wget http://www2.census.gov/geo/tiger/TIGER2016/PLACE/tl_2016_41_place.zip --mirror --reject=html
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/PLACE
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_2016_41*_place.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_place(CONSTRAINT pk_OR_place PRIMARY KEY (plcidfp) ) INHERITS(tiger.place);" 
${SHP2PGSQL} -D -c -s 4269 -g the_geom   -W "latin1" tl_2016_41_place.dbf tiger_staging.or_place | ${PSQL}
${PSQL} -c "ALTER TABLE tiger_staging.OR_place RENAME geoid TO plcidfp;SELECT loader_load_staged_data(lower('OR_place'), lower('OR_place')); ALTER TABLE tiger_data.OR_place ADD CONSTRAINT uidx_OR_place_gid UNIQUE (gid);"
${PSQL} -c "CREATE INDEX idx_OR_place_soundex_name ON tiger_data.OR_place USING btree (soundex(name));"
${PSQL} -c "CREATE INDEX tiger_data_OR_place_the_geom_gist ON tiger_data.OR_place USING gist(the_geom);"
${PSQL} -c "ALTER TABLE tiger_data.OR_place ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
cd /gisdata
wget http://www2.census.gov/geo/tiger/TIGER2016/COUSUB/tl_2016_41_cousub.zip --mirror --reject=html
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/COUSUB
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_2016_41*_cousub.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_cousub(CONSTRAINT pk_OR_cousub PRIMARY KEY (cosbidfp), CONSTRAINT uidx_OR_cousub_gid UNIQUE (gid)) INHERITS(tiger.cousub);" 
${SHP2PGSQL} -D -c -s 4269 -g the_geom   -W "latin1" tl_2016_41_cousub.dbf tiger_staging.or_cousub | ${PSQL}
${PSQL} -c "ALTER TABLE tiger_staging.OR_cousub RENAME geoid TO cosbidfp;SELECT loader_load_staged_data(lower('OR_cousub'), lower('OR_cousub')); ALTER TABLE tiger_data.OR_cousub ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
${PSQL} -c "CREATE INDEX tiger_data_OR_cousub_the_geom_gist ON tiger_data.OR_cousub USING gist(the_geom);"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_cousub_countyfp ON tiger_data.OR_cousub USING btree(countyfp);"
cd /gisdata
wget http://www2.census.gov/geo/tiger/TIGER2016/TRACT/tl_2016_41_tract.zip --mirror --reject=html
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/TRACT
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_2016_41*_tract.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_tract(CONSTRAINT pk_OR_tract PRIMARY KEY (tract_id) ) INHERITS(tiger.tract); " 
${SHP2PGSQL} -D -c -s 4269 -g the_geom   -W "latin1" tl_2016_41_tract.dbf tiger_staging.or_tract | ${PSQL}
${PSQL} -c "ALTER TABLE tiger_staging.OR_tract RENAME geoid TO tract_id;  SELECT loader_load_staged_data(lower('OR_tract'), lower('OR_tract')); "
	${PSQL} -c "CREATE INDEX tiger_data_OR_tract_the_geom_gist ON tiger_data.OR_tract USING gist(the_geom);"
	${PSQL} -c "VACUUM ANALYZE tiger_data.OR_tract;"
	${PSQL} -c "ALTER TABLE tiger_data.OR_tract ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
cd /gisdata
wget http://www2.census.gov/geo/tiger/TIGER2016/BG/tl_2016_41_bg.zip --mirror --reject=html
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/BG
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_2016_41*_bg.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_bg(CONSTRAINT pk_OR_bg PRIMARY KEY (bg_id)) INHERITS(tiger.bg);" 
${SHP2PGSQL} -D -c -s 4269 -g the_geom   -W "latin1" tl_2016_41_bg.dbf tiger_staging.or_bg | ${PSQL}
${PSQL} -c "ALTER TABLE tiger_staging.OR_bg RENAME geoid TO bg_id;  SELECT loader_load_staged_data(lower('OR_bg'), lower('OR_bg')); "
${PSQL} -c "ALTER TABLE tiger_data.OR_bg ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
${PSQL} -c "CREATE INDEX tiger_data_OR_bg_the_geom_gist ON tiger_data.OR_bg USING gist(the_geom);"
${PSQL} -c "vacuum analyze tiger_data.OR_bg;"
cd /gisdata
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/FACES/
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_*_41*_faces*.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_faces(CONSTRAINT pk_OR_faces PRIMARY KEY (gid)) INHERITS(tiger.faces);" 
for z in *faces*.dbf; do
${SHP2PGSQL} -D   -D -s 4269 -g the_geom -W "latin1" $z tiger_staging.OR_faces | ${PSQL}
${PSQL} -c "SELECT loader_load_staged_data(lower('OR_faces'), lower('OR_faces'));"
done

${PSQL} -c "CREATE INDEX tiger_data_OR_faces_the_geom_gist ON tiger_data.OR_faces USING gist(the_geom);"
	${PSQL} -c "CREATE INDEX idx_tiger_data_OR_faces_tfid ON tiger_data.OR_faces USING btree (tfid);"
	${PSQL} -c "CREATE INDEX idx_tiger_data_OR_faces_countyfp ON tiger_data.OR_faces USING btree (countyfp);"
	${PSQL} -c "ALTER TABLE tiger_data.OR_faces ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
	${PSQL} -c "vacuum analyze tiger_data.OR_faces;"
cd /gisdata
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/FEATNAMES/
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_*_41*_featnames*.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_featnames(CONSTRAINT pk_OR_featnames PRIMARY KEY (gid)) INHERITS(tiger.featnames);ALTER TABLE tiger_data.OR_featnames ALTER COLUMN statefp SET DEFAULT '41';" 
for z in *featnames*.dbf; do
${SHP2PGSQL} -D   -D -s 4269 -g the_geom -W "latin1" $z tiger_staging.OR_featnames | ${PSQL}
${PSQL} -c "SELECT loader_load_staged_data(lower('OR_featnames'), lower('OR_featnames'));"
done

${PSQL} -c "CREATE INDEX idx_tiger_data_OR_featnames_snd_name ON tiger_data.OR_featnames USING btree (soundex(name));"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_featnames_lname ON tiger_data.OR_featnames USING btree (lower(name));"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_featnames_tlid_statefp ON tiger_data.OR_featnames USING btree (tlid,statefp);"
${PSQL} -c "ALTER TABLE tiger_data.OR_featnames ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
${PSQL} -c "vacuum analyze tiger_data.OR_featnames;"
cd /gisdata
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/EDGES/
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_*_41*_edges*.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_edges(CONSTRAINT pk_OR_edges PRIMARY KEY (gid)) INHERITS(tiger.edges);" 
for z in *edges*.dbf; do
${SHP2PGSQL} -D   -D -s 4269 -g the_geom -W "latin1" $z tiger_staging.OR_edges | ${PSQL}
${PSQL} -c "SELECT loader_load_staged_data(lower('OR_edges'), lower('OR_edges'));"
done

${PSQL} -c "ALTER TABLE tiger_data.OR_edges ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_edges_tlid ON tiger_data.OR_edges USING btree (tlid);"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_edgestfidr ON tiger_data.OR_edges USING btree (tfidr);"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_edges_tfidl ON tiger_data.OR_edges USING btree (tfidl);"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_edges_countyfp ON tiger_data.OR_edges USING btree (countyfp);"
${PSQL} -c "CREATE INDEX tiger_data_OR_edges_the_geom_gist ON tiger_data.OR_edges USING gist(the_geom);"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_edges_zipl ON tiger_data.OR_edges USING btree (zipl);"
${PSQL} -c "CREATE TABLE tiger_data.OR_zip_state_loc(CONSTRAINT pk_OR_zip_state_loc PRIMARY KEY(zip,stusps,place)) INHERITS(tiger.zip_state_loc);"
${PSQL} -c "INSERT INTO tiger_data.OR_zip_state_loc(zip,stusps,statefp,place) SELECT DISTINCT e.zipl, 'OR', '41', p.name FROM tiger_data.OR_edges AS e INNER JOIN tiger_data.OR_faces AS f ON (e.tfidl = f.tfid OR e.tfidr = f.tfid) INNER JOIN tiger_data.OR_place As p ON(f.statefp = p.statefp AND f.placefp = p.placefp ) WHERE e.zipl IS NOT NULL;"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_zip_state_loc_place ON tiger_data.OR_zip_state_loc USING btree(soundex(place));"
${PSQL} -c "ALTER TABLE tiger_data.OR_zip_state_loc ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
${PSQL} -c "vacuum analyze tiger_data.OR_edges;"
${PSQL} -c "vacuum analyze tiger_data.OR_zip_state_loc;"
${PSQL} -c "CREATE TABLE tiger_data.OR_zip_lookup_base(CONSTRAINT pk_OR_zip_state_loc_city PRIMARY KEY(zip,state, county, city, statefp)) INHERITS(tiger.zip_lookup_base);"
${PSQL} -c "INSERT INTO tiger_data.OR_zip_lookup_base(zip,state,county,city, statefp) SELECT DISTINCT e.zipl, 'OR', c.name,p.name,'41'  FROM tiger_data.OR_edges AS e INNER JOIN tiger.county As c  ON (e.countyfp = c.countyfp AND e.statefp = c.statefp AND e.statefp = '41') INNER JOIN tiger_data.OR_faces AS f ON (e.tfidl = f.tfid OR e.tfidr = f.tfid) INNER JOIN tiger_data.OR_place As p ON(f.statefp = p.statefp AND f.placefp = p.placefp ) WHERE e.zipl IS NOT NULL;"
${PSQL} -c "ALTER TABLE tiger_data.OR_zip_lookup_base ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
${PSQL} -c "CREATE INDEX idx_tiger_data_OR_zip_lookup_base_citysnd ON tiger_data.OR_zip_lookup_base USING btree(soundex(city));" 
cd /gisdata
cd /gisdata/www2.census.gov/geo/tiger/TIGER2016/ADDR/
rm -f ${TMPDIR}/*.*
${PSQL} -c "DROP SCHEMA IF EXISTS tiger_staging CASCADE;"
${PSQL} -c "CREATE SCHEMA tiger_staging;"
for z in tl_*_41*_addr*.zip ; do $UNZIPTOOL -o -d $TMPDIR $z; done
cd $TMPDIR;

${PSQL} -c "CREATE TABLE tiger_data.OR_addr(CONSTRAINT pk_OR_addr PRIMARY KEY (gid)) INHERITS(tiger.addr);ALTER TABLE tiger_data.OR_addr ALTER COLUMN statefp SET DEFAULT '41';" 
for z in *addr*.dbf; do
${SHP2PGSQL} -D   -D -s 4269 -g the_geom -W "latin1" $z tiger_staging.OR_addr | ${PSQL}
${PSQL} -c "SELECT loader_load_staged_data(lower('OR_addr'), lower('OR_addr'));"
done

${PSQL} -c "ALTER TABLE tiger_data.OR_addr ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
	${PSQL} -c "CREATE INDEX idx_tiger_data_OR_addr_least_address ON tiger_data.OR_addr USING btree (least_hn(fromhn,tohn) );"
	${PSQL} -c "CREATE INDEX idx_tiger_data_OR_addr_tlid_statefp ON tiger_data.OR_addr USING btree (tlid, statefp);"
	${PSQL} -c "CREATE INDEX idx_tiger_data_OR_addr_zip ON tiger_data.OR_addr USING btree (zip);"
	${PSQL} -c "CREATE TABLE tiger_data.OR_zip_state(CONSTRAINT pk_OR_zip_state PRIMARY KEY(zip,stusps)) INHERITS(tiger.zip_state); "
	${PSQL} -c "INSERT INTO tiger_data.OR_zip_state(zip,stusps,statefp) SELECT DISTINCT zip, 'OR', '41' FROM tiger_data.OR_addr WHERE zip is not null;"
	${PSQL} -c "ALTER TABLE tiger_data.OR_zip_state ADD CONSTRAINT chk_statefp CHECK (statefp = '41');"
	${PSQL} -c "vacuum analyze tiger_data.OR_addr;"
