#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# Copy custom project config overrides
/stack/php/inject-config.sh

# Manage permissions
/stack/php/manage-permissions.sh

# Wait for work-dir to exist (docker-sync workaround since the synced contents are not available at container start)
if [ ! "$1" == "" ]; then
    while [ ! -d "$1" ]
    do
      sleep 1
      ls -l "/app"
    done
    ls -l "$1"
    cd "$1"
fi

# Start a shell
bash
