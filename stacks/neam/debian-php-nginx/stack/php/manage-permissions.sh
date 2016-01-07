#!/usr/bin/env bash

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# Ensures all newly created files will be 775, instead of the debian default of 755
# Overcomes the problem of docker-produced files in a shared-volume not being
# readable or writeable by the non-root user in the docker host.
umask 002

# Make sure files data media directory exists
mkdir -p /files/$DATA/media

if [ "$RUNNING_LOCALLY" == "1" ]; then

  # Work around permission errors locally by making sure that "www-data" uses the same uid and gid as the host volume
  TARGET_UID=$(stat -c "%u" /app)
  usermod -o -u $TARGET_UID www-data
  TARGET_GID=$(stat -c "%g" /app)
  groupmod -o -g $TARGET_GID www-data

  # Prepare writable directories
  # This needs to be run outside the docker container - does not have any effect when running as part of the start script here...
  #/app/stack/src/set-writable-local.sh

else

  # Prepare writable directories
  cd /app
  /app/stack/src/set-writable-remote.sh
  cd -

fi