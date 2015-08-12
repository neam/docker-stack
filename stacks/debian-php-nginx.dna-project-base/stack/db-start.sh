#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# set config
DBREF=default

# install if not installed
if [ ! -d ../docker-persistent-db/ ]; then
  git clone --recursive https://github.com/neam/docker-persistent-db.git ../docker-persistent-db/
  ../docker-persistent-db/install
fi

# run actual commands
cd ../docker-persistent-db/
./commands db:create $DBREF
LOCAL_DATABASE_PORT=$(cat .db/port_$DBREF)
LOCAL_DATABASE_PASSWORD=$(cat .db/pwd_$DBREF)
cd -

docker-compose run builder stack/db-set-local-config.sh $LOCAL_DATABASE_PORT $LOCAL_DATABASE_PASSWORD

echo "Database ready and configured for local development"

exit 0
