#!/bin/bash

# This script is run within the nginx container on start

# Fail on any error
set -o errexit

# Verify that APP_DIR is set
if [ "$APP_DIR" == "" ]; then
    echo "Error: APP_DIR must be set (to the app base directory)"
    exit 1;
fi
if [ "$NGINX_CONFD" == "" ]; then
    echo "Error: NGINX_CONFD must be set (to the nginx conf.d directory)"
    exit 1;
fi

# Copy custom project config overrides
if [ "$(ls $APP_DIR/server-config/nginx/conf.d/)" ]; then
    cp -r $APP_DIR/server-config/nginx/conf.d/* "$NGINX_CONFD"/
fi

if [ ! -n "$PHPFPM_1_PORT_9000_TCP_ADDR" ] ; then
    echo "Warning: The env var PHPFPM_1_PORT_9000_TCP_ADDR is missing, so the generated configuration will not work"
fi

if [ ! -n "$PHPFPM_1_PORT_9000_TCP_PORT" ] ; then
    echo "Warning: The env var PHPFPM_1_PORT_9000_TCP_PORT is missing, so the generated configuration will not work"
fi

# Setup config variables only available at runtime
$(dirname $0)/replace-env-tokens.sh "$NGINX_CONFD"

# Uncomment to also override the core config file with project-specific ones
#cp -r $APP_DIR/server-config/nginx/nginx.conf "$NGINX_CONFD"/../

# Run the command sent as command line arguments
$@
