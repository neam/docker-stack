#!/bin/bash

# show commands
set -x

# fail on any error
set -o errexit

export PREFER=$PREFER

script_path=`dirname $0`
$script_path/install-core-deps.sh
$script_path/install-local-deps.sh

exit 0
