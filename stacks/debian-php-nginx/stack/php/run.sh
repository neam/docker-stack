#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# Copy custom project config overrides

  # PHP-FPM
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

  # HHVM cli
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

  # HHVM fastcgi server
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

# Ensures all newly created files will be 775, instead of the debian default of 755
# Overcomes the problem of docker-produced files in a shared-volume not being
# readable or writeable by the non-root user in the docker host.
umask 002

# Make sure files data media directory exists
mkdir -p /files/$DATA/media

if [ "$RUNNING_LOCALLY" == "1" ]; then

  # Work around permission errors locally by making sure that "www-data" uses the same uid and gid as the host volume
  TARGET_UID=$(stat -c "%u" /app)
  usermod -o -u $TARGET_UID www-data
  TARGET_GID=$(stat -c "%g" /app)
  groupmod -o -g $TARGET_GID www-data

  # Prepare writable directories
  # This needs to be run outside the docker container - does not have any effect when running as part of the start script here...
  #/app/stack/src/set-writable-local.sh

else

  # Prepare writable directories
  cd /app
  /app/stack/src/set-writable-remote.sh
  cd -

fi

# Echo some directory listings so that we can verify that things are set up properly
ls -l /app/
ls -l /files/$DATA/media

# Uncomment in order to use hhvm for cli
/usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/hhvm 60

# Run the desired php cgi process manager (use either php-fpm or hhvm)
#php5-fpm
hhvm -m server -c /etc/hhvm/server.ini -u www-data
