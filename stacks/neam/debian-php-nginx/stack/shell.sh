#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# run actual command
echo "Starting /bin/bash in a new shell container... "
docker-compose -f docker-compose.yml run --rm shell

exit 0
