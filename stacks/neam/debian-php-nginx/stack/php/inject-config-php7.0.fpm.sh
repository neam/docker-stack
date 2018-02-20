#!/usr/bin/env bash

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# ==== PHP-FPM ====

cp /stack/php/php.ini /etc/php/7.0/fpm/php.ini
for configfile in /stack/php/conf.d/*; do
    cp $configfile /etc/php/7.0/fpm/conf.d/
done
for configfile in /stack/php/php-fpm/pool.d/*; do
    cp $configfile /etc/php/7.0/fpm/pool.d/
done
cp /stack/php/php-fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf

# Add local-only config overrides
if [ "$RUNNING_LOCALLY" == "1" ]; then
  for configfile in /stack/php/conf.d-local/*; do
    cp $configfile /etc/php/7.0/fpm/conf.d/
  done
fi

# Setup config variables only available at runtime
if [ ! "$LOAD_XDEBUG_EXTENSION" == "1" ]; then
  rm /etc/php/7.0/fpm/conf.d/*xdebug*
fi
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /etc/php/7.0/fpm/conf.d/app.ini
sed -i "s|\${XDEBUG_DEFAULT_ENABLE}|${XDEBUG_DEFAULT_ENABLE}|" /etc/php/7.0/fpm/conf.d/app.ini
PHP_CONF_DIR=/etc/php/7.0
sed -i "s|\${PHP_CONF_DIR}|${PHP_CONF_DIR}|" /etc/php/7.0/fpm/php-fpm.conf
