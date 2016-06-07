#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# make sure no other stack's containers are using the ports that our stack uses
docker ps | grep -v _PROJECT_ | grep '0.0.0.0:80->' | awk '{ print $1 }' | xargs docker kill
docker ps | grep -v _PROJECT_ | grep '0.0.0.0:33306->' | awk '{ print $1 }' | xargs docker kill

# run actual command
docker-stack local up --build -d

exit 0
