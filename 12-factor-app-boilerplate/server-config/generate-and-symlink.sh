#!/bin/bash

# fail on any error
set -o errexit

# always run from project root
script_path=`dirname $0`
cd $script_path/..

# Generate project nginx and php-fpm configuration based on composer.json

export BUILD_DIR="$(pwd)"
export GENERATOR_DIR="vendor/neam/yii-dna-deployment/server-config-generator"
$GENERATOR_DIR/generate.sh

# Symlink project configuration to where the docker compose stack expects them
mkdir -p /etc/nginx/conf.d
mkdir -p /usr/local/etc/php/conf.d
#ln -sf /app/server-config/php/php-fpm.conf /usr/local/etc/php-fpm.conf
ln -sf /app/server-config/php/conf.d/php.ini /usr/local/etc/php/conf.d/php.ini
ln -sf /app/server-config/php/conf.d/env.ini /usr/local/etc/php/conf.d/env.ini
ln -sf /app/server-config/php/conf.d/project.ini /usr/local/etc/php/conf.d/project.ini
#ln -sf /app/server-config/nginx/nginx.conf /etc/nginx/nginx.conf
ln -sf /app/server-config/nginx/conf.d/00-defaults.conf /etc/nginx/conf.d/00-defaults.conf
ln -sf /app/server-config/nginx/conf.d/project.conf /etc/nginx/conf.d/project.conf

exit 0
