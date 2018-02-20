#!/usr/bin/env bash

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# ==== PHP-FPM ====

if [ -d /etc/php/7.1/fpm/ ]; then
    /stack/php/inject-config-php7.1.fpm.sh
fi

if [ -d /etc/php/7.1/cli/ ]; then
    /stack/php/inject-config-php7.1.cli.sh
fi
