#!/bin/bash
set -e

# Script to workaround docker-machine/boot2docker OSX host volume issues: https://github.com/docker-library/mysql/issues/99

echo '* Working around permission errors locally by making sure that "mysql" uses the same uid and gid as the host volume'
TARGET_UID=$(stat -c "%u" /var/lib/mysql)
echo '-- Setting mysql user to use uid '$TARGET_UID
usermod -o -u $TARGET_UID mysql || true
TARGET_GID=$(stat -c "%g" /var/lib/mysql)
echo '-- Setting mysql group to use gid '$TARGET_GID
groupmod -o -g $TARGET_GID mysql || true
echo
echo '* Starting MySQL'
chown -R mysql:root /var/run/mysqld/

# RDS defaults (https://gist.github.com/onyxraven/3834532)
RDS_DEFAULTS="--tmp_table_size=16777216 --max_heap_table_size=16777216 --table_open_cache=400 --thread_cache_size=0 --innodb_flush_log_at_trx_commit=1 --max_allowed_packet=1048576"

# Start server locally
#/entrypoint.sh mysqld --user=mysql --console $RDS_DEFAULTS
# no rds defaults for db imports
/entrypoint.sh mysqld --user=mysql --console --sql_mode=NO_ENGINE_SUBSTITUTION
