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
    /app/stack/php/inject-config-php5.sh
  fi
  if [ "$PHP_PACKAGE_NAME_VERSION" == "7.0" ]; then
    /app/stack/php/inject-config-php7.0.sh
  fi
fi
