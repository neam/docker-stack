#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

set -x

if [ "$1" == "" ]; then
  FLAVOR="php7.0"
else
  FLAVOR=$1
fi

# run actual command
echo "Starting /bin/bash in a new tester container... "
docker-compose -f docker-compose.yml run --rm tester-$FLAVOR

exit 0
