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
echo "Starting /bin/bash in a new tester container. Press ENTER to see the prompt (some sort of bug...)"
docker-stack local run tester-$FLAVOR

exit 0
