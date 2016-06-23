#!/usr/bin/env bash

# update before the show begins
apt-get update

# Some basic tools
apt-get install -y vim htop

apt-get install -y postgresql-9.3 postgresql-contrib-9.3 postgresql-9.3-postgis-2.1

# Install imposm importer
wget http://imposm.org/static/rel/imposm3-0.2.0dev-20160517-3c27127-linux-x86-64.tar.gz
tar -xvzf imposm3-0.2.0dev-20160517-3c27127-linux-x86-64.tar.gz

# Download Switzerland
wget http://download.geofabrik.de/europe/switzerland-latest.osm.pbf

# Create Database
sudo -u postgres createdb osm_swiss
sudo -u postgres psql -d osm_swiss -c "CREATE EXTENSION POSTGIS;"

sudo rm /etc/postgresql/9.3/main/pg_hba.conf
sudo sh -c  "echo 'local all all trust' >> /etc/postgresql/9.3/main/pg_hba.conf"
sudo sh -c  "echo 'host all all all trust' >> /etc/postgresql/9.3/main/pg_hba.conf"
sudo sh -c  "echo listen_addresses = \'*\' >> /etc/postgresql/9.3/main/postgresql.conf"

# restart postgres so that all changes get activated
sudo service postgresql restart

# import data
sudo -u postgres imposm3-0.2.0dev-20160517-3c27127-linux-x86-64/imposm3 import -read switzerland-latest.osm.pbf -write -mapping imposm3-0.2.0dev-20160517-3c27127-linux-x86-64/mapping.json -connection postgis://localhost/osm_swiss -deployproduction

