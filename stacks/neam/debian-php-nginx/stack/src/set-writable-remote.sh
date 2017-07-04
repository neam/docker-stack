#!/usr/bin/env bash

chmod -R 777 /local-tmp-files
if [ -d "/files" ]; then
  chmod -R 777 /files
fi
chmod -R 777 frontend/app/runtime
chmod -R 777 frontend/www/assets
chmod -R 777 backend/app/runtime
chmod -R 777 backend/www/assets

exit 0