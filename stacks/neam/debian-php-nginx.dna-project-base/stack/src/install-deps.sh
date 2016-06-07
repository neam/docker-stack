#!/bin/bash

# show commands
set -x

# fail on any error
set -o errexit

export PREFER=$PREFER

if [ -d /root/.docker-host-ssh ]; then
  echo '* Working around permission errors locally by copying .ssh config temporarily instead of using host-volume-mounted ditos'
  cp -r /root/.docker-host-ssh /root/.ssh
fi

script_path=`dirname $0`
$script_path/install-core-deps.sh
$script_path/install-local-deps.sh

exit 0
