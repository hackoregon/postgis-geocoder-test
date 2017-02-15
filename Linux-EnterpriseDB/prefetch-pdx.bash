#! /bin/bash

wget http://www2.census.gov/geo/tiger/TIGER2016/STATE/tl_2016_us_state.zip --mirror --reject=html
wget http://www2.census.gov/geo/tiger/TIGER2016/COUNTY/tl_2016_us_county.zip --mirror --reject=html
wget http://www2.census.gov/geo/tiger/TIGER2016/PLACE/tl_2016_41_place.zip --mirror --reject=html
wget http://www2.census.gov/geo/tiger/TIGER2016/COUSUB/tl_2016_41_cousub.zip --mirror --reject=html
wget http://www2.census.gov/geo/tiger/TIGER2016/TRACT/tl_2016_41_tract.zip --mirror --reject=html
wget http://www2.census.gov/geo/tiger/TIGER2016/BG/tl_2016_41_bg.zip --mirror --reject=html
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/FACES/tl_2016_41005_faces.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/FACES/tl_2016_41051_faces.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/FACES/tl_2016_41067_faces.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/FEATNAMES/tl_2016_41005_featnames.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/FEATNAMES/tl_2016_41051_featnames.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/FEATNAMES/tl_2016_41067_featnames.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/EDGES/tl_2016_41005_edges.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/EDGES/tl_2016_41051_edges.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/EDGES/tl_2016_41067_edges.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/ADDR/tl_2016_41005_addr.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/ADDR/tl_2016_41051_addr.zip 
wget --mirror  http://www2.census.gov/geo/tiger/TIGER2016/ADDR/tl_2016_41067_addr.zip 

zip -9r prefetch-pdx.zip www2.census.gov prefetch-pdx.bash
