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

cd $script_path/../..
export project_abspath=$(pwd)

# make sure that the shorthand "composer" is available and refers to using our shipped composer.phar (for the sake of consistency)
function composer() {
    php $project_abspath/composer.phar $@
}
export -f composer

$script_path/install-core-deps.sh
$script_path/install-local-deps.sh

exit 0
