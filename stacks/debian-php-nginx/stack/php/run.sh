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

if [ "$RUNNING_LOCALLY" == "1" ]; then

for configfile in /app/stack/php/conf.d-local/*; do
    cp $configfile /etc/php5/fpm/conf.d/
done

  # Work around permission errors locally by making sure that "www-data" uses the same uid and gid as the host volume
  TARGET_UID=$(stat -c "%g" /app)
  usermod -o -u $TARGET_UID www-data
  TARGET_GID=$(stat -c "%g" /app)
  groupmod -o -g $TARGET_GID www-data

else

  # Prepare writable directories - TODO: Prevent app from writing to /app
  chmod -R 777 /app/foo/app/runtime
  chmod -R 777 /app/foo/www/assets

fi

# Run the command sent as command line arguments
php5-fpm
