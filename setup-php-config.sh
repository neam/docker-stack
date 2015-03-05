#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Verify that APP_DIR is set
if [ "$APP_DIR" == "" ]; then
    echo "APP_DIR must be set to the app base directory"
    exit;
fi

# Copy custom project config overrides
if [ "$(ls $APP_DIR/server-config/php/conf.d/)" ]; then
    cp -r $APP_DIR/server-config/php/conf.d/* "$PHP_CONFD"/
fi

# Setup config variables only available at runtime
$(dirname $0)/replace-env-tokens.sh "$PHP_CONFD"

# Make all environment variables available to php
echo "" > "$PHP_CONFD/env.ini"
for var in $(env | cut -f1 -d=); do
  echo "env[$var] = \$${var}" >> "$PHP_CONFD/env.ini"
done

# Uncomment to also override the core config file with project-specific ones
#cp -r $APP_DIR/server-config/php/php-fpm.conf "$PHP_CONFD"/../

exit 0
