#!/bin/bash

# This script is run within the nginx:1.7-based container on start

# Fail on any error
set -o errexit

# Setup config variables only available at runtime
if [ ! -n "$PHPFPM_PORT_9000_TCP_ADDR" ] ; then
    echo "Error: The env var PHPFPM_PORT_9000_TCP_ADDR is missing - make sure the linked PHP container is running"
    exit 1;
fi
if [ ! -n "$PHPFPM_PORT_9000_TCP_PORT" ] ; then
    echo "Error: The env var PHPFPM_PORT_9000_TCP_PORT is missing- make sure the linked PHP container is running"
    exit 1;
fi
sed -i "s|\${PHPFPM_PORT_9000_TCP_ADDR}|${PHPFPM_PORT_9000_TCP_ADDR}|" /etc/nginx/conf.d/php-fpm.conf
sed -i "s|\${PHPFPM_PORT_9000_TCP_PORT}|${PHPFPM_PORT_9000_TCP_PORT}|" /etc/nginx/conf.d/php-fpm.conf

# Example of using environment variable in configuration at runtime
if [ ! -n "$NGINX_ERROR_LOG_LEVEL" ] ; then
    NGINX_ERROR_LOG_LEVEL="warn"
fi
sed -i "s|\${NGINX_ERROR_LOG_LEVEL}|${NGINX_ERROR_LOG_LEVEL}|" /etc/nginx/nginx.conf

# Run nginx
nginx -g 'daemon off;'
