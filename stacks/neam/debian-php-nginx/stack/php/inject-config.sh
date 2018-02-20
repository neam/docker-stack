#!/usr/bin/env bash

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# Inject the appropriate config
if [ "$HHVM" == "1" ]; then
  /app/stack/php/inject-config-hhvm.sh
else
  if [ "$PHP_PACKAGE_NAME_VERSION" == "5" ]; then
    echo "PHP 5 is no longer included in the Docker stack images"
    exit 1;
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "7.0" ]; then
    /app/stack/php/inject-config-php7.0.sh
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "7.1" ]; then
    /app/stack/php/inject-config-php7.1.sh
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "" ]; then
    echo "Error: PHP_PACKAGE_NAME_VERSION is empty so no config could be injected"
    exit 1
  fi
fi
