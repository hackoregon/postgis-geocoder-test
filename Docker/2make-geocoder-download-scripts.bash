#! /bin/bash

# execute script builder
psql -d geocoder -f make-tiger-scripts.psql
chmod +x /gisdata/*.bash
