#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Copy custom project config overrides
for configfile in /app/stack/php/conf.d/*; do
    cp $configfile /etc/php5/fpm/conf.d/
done

# Setup config variables only available at runtime
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /etc/php5/fpm/conf.d/app.ini

# Make all environment variables available to php-fpm at runtime
echo "" > "/etc/php5/fpm/conf.d/env.ini"
for var in $(env | cut -f1 -d=); do
  echo "env[$var] = \$${var}" >> "/etc/php5/fpm/conf.d/env.ini"
done

# TODO: Local only

for configfile in /app/stack/php/conf.d-local/*; do
    cp $configfile /etc/php5/fpm/conf.d/
done

# Work around permission errors locally TODO only if local
usermod -u 1000 www-data

# Run the command sent as command line arguments
php5-fpm
