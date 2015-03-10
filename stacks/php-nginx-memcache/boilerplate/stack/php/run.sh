#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Copy custom project config overrides
if [ "$(ls /app/stack/php/conf.d/)" ]; then
    cp -r /app/stack/php/conf.d/* /usr/local/etc/php/conf.d/
fi

# Setup config variables only available at runtime
sed -i "s|\${FOO}|${FOO}|" /usr/local/etc/php/conf.d/app.ini

# Make all environment variables available to php-fpm at runtime
echo "" > "/usr/local/etc/php/env.ini"
for var in $(env | cut -f1 -d=); do
  echo "env[$var] = \$${var}" >> "/usr/local/etc/php/env.ini"
done

# Run the command sent as command line arguments
php-fpm
