#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# set config
DBREF=default

# run actual commands
cd ../docker-md-plugin/
./commands mariadb:create $DBREF
MD_DATABASE_PORT=$(cat .mariadb/port_$DBREF)
MD_DATABASE_PASSWORD=$(cat .mariadb/pwd_$DBREF)
cd -

docker-compose run builder stack/db-set-local-config.sh $MD_DATABASE_PORT $MD_DATABASE_PASSWORD

echo "Database ready and configured for local development"

exit 0
