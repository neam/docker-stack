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

# Run the desired php cgi process manager (use either php-fpm or hhvm)
if [ "$HHVM" == "1" ]; then
  hhvm -m server -c /etc/hhvm/server.ini -u www-data
else
  if [ "$PHP_PACKAGE_NAME_VERSION" == "5" ]; then
    echo "PHP 5 is no longer included in the Docker stack images"
    exit 1;
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "7.0" ]; then
    php-fpm7.0
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "7.1" ]; then
    php-fpm7.1
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "" ]; then
    echo "Error: PHP_PACKAGE_NAME_VERSION is empty so no config could be injected"
    exit 1
  fi
fi
