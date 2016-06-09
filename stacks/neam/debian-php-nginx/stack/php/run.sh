#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# Copy custom project config overrides
/app/stack/php/inject-config.sh

# Manage permissions
/app/stack/php/manage-permissions.sh

# Run the desired php cgi process manager (use either php-fpm or hhvm)
if [ "$HHVM" == "1" ]; then
  hhvm -m server -c /etc/hhvm/server.ini -u www-data
else
  if [ "$PHP_PACKAGE_NAME_VERSION" == "5" ]; then
    php5-fpm
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "7.0" ]; then
    php-fpm7.0
  fi
fi
