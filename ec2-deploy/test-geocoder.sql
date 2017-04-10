SELECT
  g.rating As r,
  ST_X(geomout) As lon,
  ST_Y(geomout) As lat,
  pprint_addy(addy) As paddress
FROM
  geocode(
    '317 NW Glisan St, Portland, OR 97209'
  ) As g;
SELECT
  pprint_addy(addy),
  st_astext(geomout),
  rating
FROM
  geocode_intersection(
    'Glisan', '3rd', 'OR', 'Portland'
  );
