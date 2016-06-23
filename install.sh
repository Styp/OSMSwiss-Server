#!/usr/bin/env bash

vagrant up

mkdir osm-bright/shp/

wget http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
wget http://data.openstreetmapdata.com/land-polygons-split-3857.zip

unzip simplified-land-polygons-complete-3857.zip -d osm-bright/shp
unzip land-polygons-split-3857.zip -d osm-bright/shp

cd osm-bright
./make.py
cd ..
