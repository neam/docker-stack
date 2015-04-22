#!/bin/bash
set -x
# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# set config
MD_DATABASE_PORT=$1
MD_DATABASE_PASSWORD=$2
sed -i 's/^DATABASE_PORT=.*/DATABASE_PORT='$MD_DATABASE_PORT'/g' .env
sed -i 's/^DATABASE_PASSWORD=.*/DATABASE_PASSWORD='$MD_DATABASE_PASSWORD'/g' .env
sed -i 's/^TEST_DB_PASSWORD=.*/TEST_DB_PASSWORD='$MD_DATABASE_PASSWORD'/g' .env

cat .env | grep '^DATABASE_PORT='
cat .env | grep '^DATABASE_PASSWORD='
cat .env | grep '^TEST_DB_PASSWORD='

exit 0
