#!/bin/bash

# debug
#set -x

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# make sure no other stack's containers are using the ports that our stack uses
CURRENT_DIRECTORY="$(basename $(pwd))"
DOCKERSTACKREF=${CURRENT_DIRECTORY//-/}
docker ps | grep -v ${DOCKERSTACKREF}_ | grep '0.0.0.0:80->' | awk '{ print $1 }' | xargs docker kill
docker ps | grep -v ${DOCKERSTACKREF}_ | grep '0.0.0.0:33306->' | awk '{ print $1 }' | xargs docker kill

# fail on any error
set -o errexit

# run actual command
docker-stack local up --build -d

exit 0
