#!/usr/bin/env bash

chmod -R g+rw .files/
chmod -R g+rw frontend/app/runtime
chmod -R g+rw frontend/www/assets
chmod -R g+rw backend/app/runtime
chmod -R g+rw backend/www/assets
mkdir -p tmp/xdebug/
chmod -R g+rw tmp/xdebug/

exit 0