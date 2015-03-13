#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Copy custom project config overrides
for configfile in /app/stack/php/conf.d/*; do
    cp $configfile /etc/php5/fpm/conf.d/
done
for configfile in /app/stack/php/pool.d/*; do
    cp $configfile /etc/php5/fpm/pool.d/
done
cp /app/stack/php/php-fpm.conf /etc/php5/fpm/php-fpm.conf

# Setup config variables only available at runtime
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /etc/php5/fpm/conf.d/app.ini

# TODO: Local only

for configfile in /app/stack/php/conf.d-local/*; do
    cp $configfile /etc/php5/fpm/conf.d/
done

# Work around permission errors locally TODO only if local
usermod -u 1000 www-data

# Run the command sent as command line arguments
php5-fpm
