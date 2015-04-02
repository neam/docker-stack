#!/bin/bash

# fail on any error
set -o errexit

if [ "$PREFER" == "" ]; then
  PREFER=source
fi

composer install --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs

exit 0
