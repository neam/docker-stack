#!/usr/bin/env bash

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# ==== PHP-FPM ====

cp /app/stack/php/php.ini /etc/php5/fpm/php.ini
for configfile in /app/stack/php/conf.d/*; do
    cp $configfile /etc/php5/fpm/conf.d/
done
for configfile in /app/stack/php/php-fpm/pool.d/*; do
    cp $configfile /etc/php5/fpm/pool.d/
done
cp /app/stack/php/php-fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf

# Add local-only config
if [ "$RUNNING_LOCALLY" == "1" ]; then
  for configfile in /app/stack/php/conf.d-local/*; do
    cp $configfile /etc/php5/fpm/conf.d/
  done
fi

# Setup config variables only available at runtime
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /etc/php5/fpm/conf.d/app.ini
sed -i "s|\${XDEBUG_DEFAULT_ENABLE}|${XDEBUG_DEFAULT_ENABLE}|" /etc/php5/fpm/conf.d/app.ini

# ==== HHVM cli ====

cp /app/stack/php/php.ini /etc/hhvm/php.ini # Note: The HHVM cli is here configured to use default php.ini contents that came with php5-fpm
cat /app/stack/php/hhvm/php.ini >> /etc/hhvm/php.ini # Default hhvm-specific config used for HHVM cli and HHVM fastcgi server
for configfile in /app/stack/php/conf.d/*; do
    cat $configfile >> /etc/hhvm/php.ini
done

# Add local-only config
if [ "$RUNNING_LOCALLY" == "1" ]; then
  for configfile in /app/stack/php/conf.d-local/*; do
    cat $configfile >> /etc/hhvm/php.ini
  done
fi

# Setup config variables only available at runtime
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /etc/hhvm/php.ini
sed -i "s|\${XDEBUG_DEFAULT_ENABLE}|${XDEBUG_DEFAULT_ENABLE}|" /etc/hhvm/php.ini

# ==== HHVM fastcgi server ====

cp /app/stack/php/php.ini /etc/hhvm/server.ini # Note: The HHVM fastcgi server is here configured to use default php.ini contents that came with php5-fpm
cat /app/stack/php/hhvm/php.ini >> /etc/hhvm/server.ini # Default hhvm-specific config used for HHVM cli and HHVM fastcgi server
cat /app/stack/php/hhvm/server.ini >> /etc/hhvm/server.ini # Default hhvm-specific config used for HHVM fastcgi server
for configfile in /app/stack/php/conf.d/*; do
    cat $configfile >> /etc/hhvm/server.ini
done

# Add local-only config
if [ "$RUNNING_LOCALLY" == "1" ]; then
  for configfile in /app/stack/php/conf.d-local/*; do
    cat $configfile >> /etc/hhvm/server.ini
  done
fi

# Setup config variables only available at runtime
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /etc/hhvm/server.ini
sed -i "s|\${XDEBUG_DEFAULT_ENABLE}|${XDEBUG_DEFAULT_ENABLE}|" /etc/hhvm/server.ini
