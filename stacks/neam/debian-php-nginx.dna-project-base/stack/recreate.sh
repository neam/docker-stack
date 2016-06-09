#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# run actual command
stack/stop.sh
docker-compose rm -f
stack/start.sh

exit 0
