#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# run actual command
echo "Starting /bin/bash in a new worker container... "
docker-compose -f docker-compose.yml run --rm worker

exit 0
