#!/usr/bin/env bash

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# ==== PHP-CLI ====

cp /app/stack/php/php.ini /etc/php/7.1/cli/php.ini
for configfile in /app/stack/php/conf.d/*; do
    cp $configfile /etc/php/7.1/cli/conf.d/
done

# Add local-only config overrides
if [ "$RUNNING_LOCALLY" == "1" ]; then
  for configfile in /app/stack/php/conf.d-local/*; do
    cp $configfile /etc/php/7.1/cli/conf.d/
  done
fi

# Setup config variables only available at runtime
if [ ! "$LOAD_XDEBUG_EXTENSION" == "1" ]; then
  rm /etc/php/7.1/cli/conf.d/*xdebug*
fi
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /etc/php/7.1/cli/conf.d/app.ini
sed -i "s|\${XDEBUG_DEFAULT_ENABLE}|${XDEBUG_DEFAULT_ENABLE}|" /etc/php/7.1/cli/conf.d/app.ini

# Use php7.1 for cli
/usr/bin/update-alternatives --install /usr/bin/php php /usr/bin/php7.1 60
