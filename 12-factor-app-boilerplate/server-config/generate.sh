#!/bin/bash

# This script is run separately within php-fpm and nginx containers before starting their respective service
# It could be split into two - one for nginx and one for php-fpm

# Fail on any error
set -o errexit

# Verify that APP_DIR is set
if [ "$APP_DIR" == "" ]; then
    echo "APP_DIR must be set to the app base directory"
    exit;
fi

# Paths
export PHP_CONFD="/usr/local/etc/php/conf.d"
export NGINX_CONFD="/etc/nginx/conf.d"
mkdir -p "$NGINX_CONFD"
mkdir -p "$PHP_CONFD"

# Copy custom project config overrides
if [ "$(ls $APP_DIR/server-config/php/conf.d/)" ]; then
    cp -r $APP_DIR/server-config/php/conf.d/* "$PHP_CONFD"/
fi
if [ "$(ls $APP_DIR/server-config/nginx/conf.d/)" ]; then
    cp -r $APP_DIR/server-config/nginx/conf.d/* "$NGINX_CONFD"/
fi

# Uncomment to also override the core config files with project-specific ones
#cp -r $APP_DIR/server-config/php/php-fpm.conf "$PHP_CONFD"/../
#cp -r $APP_DIR/server-config/nginx/nginx.conf "$NGINX_CONFD"/../

# Generate general project nginx and php-fpm configuration based on serialized composer.json data
if [ -f "$APP_DIR/.serialized_composer_json_data.sh" ]; then
  export GENERATOR_DIR="$APP_DIR/vendor/neam/docker-php-toolkit/server-config-generator"
  $GENERATOR_DIR/generate-server-config.sh
else
  echo "No .serialized_composer_json_data.sh found - config generation skipped"
fi

exit 0
