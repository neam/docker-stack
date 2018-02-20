#!/bin/bash
set -e

# Manage permissions
/stack/localdb/manage-permissions.sh

# RDS defaults (https://gist.github.com/onyxraven/3834532)
RDS_DEFAULTS="--tmp_table_size=16777216 --max_heap_table_size=16777216 --table_open_cache=400 --thread_cache_size=0 --innodb_flush_log_at_trx_commit=1 --max_allowed_packet=1048576"

# Start server locally
echo '* Starting MySQL'
#/entrypoint.sh mysqld --user=mysql --console $RDS_DEFAULTS
# no rds defaults for db imports
/entrypoint.sh mysqld --user=mysql --console --sql_mode=NO_ENGINE_SUBSTITUTION
