#!/usr/bin/env bash

if [ -d "/files/$DATA/media" ]; then
  chmod -R 777 /files/$DATA/media
fi
chmod -R 777 frontend/app/runtime
chmod -R 777 frontend/www/assets
chmod -R 777 backend/app/runtime
chmod -R 777 backend/www/assets

exit 0