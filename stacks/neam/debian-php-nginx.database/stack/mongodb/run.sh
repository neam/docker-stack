#!/bin/bash
set -e

# Script to workaround docker-machine/boot2docker OSX host volume issues: https://github.com/docker-library/mysql/issues/99

echo '* Working around permission errors locally by making sure that "mongodb" uses the same uid and gid as the host volume'
TARGET_UID=$(stat -c "%u" /data/db)
echo '-- Setting mongodb user to use uid '$TARGET_UID
usermod -o -u $TARGET_UID mongodb || true
TARGET_GID=$(stat -c "%g" /data/db)
echo '-- Setting mongodb group to use gid '$TARGET_GID
groupmod -o -g $TARGET_GID mongodb || true
echo
echo '* Starting MongoDB'
#chown -R mongodb:root /var/run/mongodbd/
/entrypoint.sh mongodbd --user=mongodb --console
