#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# make sure no other container is using port 80
docker ps | grep '0.0.0.0:80->' | awk '{ print $1 }' | xargs docker kill

# run actual command
docker-stack local up -d

exit 0
