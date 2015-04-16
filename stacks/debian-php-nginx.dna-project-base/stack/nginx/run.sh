#!/bin/bash

# This script is run within the nginx:1.7-based container on start

# Fail on any error
set -o errexit

# Copy nginx configuration from app directory to nginx container

# Remove existing config files
if [ "$(ls /etc/nginx/conf.d/)" ]; then
    rm /etc/nginx/conf.d/*.conf
fi

# Copy custom project include files
if [ "$(ls /app/stack/nginx/conf.d/)" ]; then
    cp -r /app/stack/nginx/conf.d/* /etc/nginx/conf.d/
fi
cp /app/stack/nginx/nginx.conf /etc/nginx/nginx.conf
cp -r /app/stack/nginx/include /etc/nginx/include

# Example of using environment variable in configuration at runtime
if [ ! -n "$NGINX_ERROR_LOG_LEVEL" ] ; then
    NGINX_ERROR_LOG_LEVEL="warn"
fi
sed -i "s|\${NGINX_ERROR_LOG_LEVEL}|${NGINX_ERROR_LOG_LEVEL}|" /etc/nginx/nginx.conf

# Setup config variables only available at runtime
sed -i "s|\${DATA}|${DATA}|" /etc/nginx/conf.d/app.conf

# Run nginx
nginx -g 'daemon off;'
