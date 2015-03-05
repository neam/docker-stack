#!/bin/bash

# This script is run separately within php-fpm and nginx containers before starting their respective service
# It could be split into two - one for nginx and one for php-fpm

# Fail on any error
set -o errexit

# Paths
export BUILD_DIR="/tmp"
export PHP_CONFD="/usr/local/etc/php/conf.d"
export NGINX_CONFD="/etc/nginx/conf.d"
mkdir -p "$NGINX_CONFD"
mkdir -p "$PHP_CONFD"

# Copy composer.json to build dir
cp /app/composer.json "$BUILD_DIR"/

# Copy custom project config overrides
if [ "$(ls /app/server-config/php/conf.d/)" ]; then
    cp -r /app/server-config/php/conf.d/* "$PHP_CONFD"/
fi
if [ "$(ls /app/server-config/nginx/conf.d/)" ]; then
    cp -r /app/server-config/nginx/conf.d/* "$NGINX_CONFD"/
fi

# Uncomment to also override the core config files with project-specific ones
#cp -r /app/server-config/php/php-fpm.conf "$PHP_CONFD"/../
#cp -r /app/server-config/nginx/nginx.conf "$NGINX_CONFD"/../

# Generate general project nginx and php-fpm configuration based on composer.json
export GENERATOR_DIR="/app/vendor/neam/yii-dna-deployment/server-config-generator"
$GENERATOR_DIR/generate.sh

exit 0
