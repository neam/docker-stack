#!/usr/bin/env bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

set -x

# run actual command
echo "Starting /bin/bash in a new tester container... "
docker-compose -f docker-compose.yml run --rm localdb /stack/localdb/shell.sh

exit 0
