#!/usr/bin/env bash

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# ==== PHP-FPM ====

if [ -d /etc/php5/fpm/ ]; then
    /app/stack/php/inject-config-php5.fpm.sh
fi

if [ -d /etc/php5/cli/ ]; then
    /app/stack/php/inject-config-php5.cli.sh
fi
