#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Copy custom project config overrides
mkdir -p /usr/local/etc/php/conf.d/
for configfile in /app/stack/php-fpm/conf.d/*; do
    cp $configfile /usr/local/etc/php/conf.d/
done
mkdir -p /usr/local/etc/php/pool.d/
for configfile in /app/stack/php-fpm/pool.d/*; do
    cp $configfile /usr/local/etc/php/pool.d/
done
cp /app/stack/php-fpm/php-fpm.conf /usr/local/etc/php-fpm.conf

# Setup config variables only available at runtime
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /usr/local/etc/php/conf.d/app.ini

# TODO: Local only
#mkdir -p /usr/local/etc/php/conf.d/
#for configfile in /app/stack/php-fpm/conf.d-local/*; do
#    cp $configfile /etc/php5/fpm/conf.d/
#done

# Work around permission errors locally TODO only if local
usermod -u 1000 www-data

# Run the command sent as command line arguments
php-fpm
