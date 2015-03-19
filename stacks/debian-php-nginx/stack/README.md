Stacks - PHP/Nginx/Memcache
===================================

## Features

* Follows Docker's one-process-per-container philosophy by having separate containers for Nginx and PHP-FPM
* Uses official PHP-FPM and Nginx Docker containers
* Includes boilerplate configuration with Docker-specific enhancements
* (Optional) a PHP-FPM an Nginx server configuration generator for generating configuration based on your composer.json

## Installation

Clone/download a copy of this repository and copy the boilerplate files to your 12-factor app base dir.

    cd my-app
    docker-stack install debian-php-nginx.memcache

Optionally, generation your project php/nginx base configuration: [Follow these instructions](../../generators/server-config-generator/README.md)

Add your project php/nginx configuration includes to the `stack/nginx/` and `stack/php/` directories.

## Usage

### Useful general commands

Change and reload php configuration on-the-fly:

    docker exec -it $PHPFPM_CID /bin/bash
    nano /usr/local/etc/php/php-fpm.ini
    kill -USR2 $(ps aux | grep 'php-fpm: master process' | grep -v grep | awk '{ print $2 }')

Change and reload nginx configuration on-the-fly:

    docker exec -it $NGINX_CID /bin/bash
    nano /etc/nginx/nginx.conf
    nginx -s reload

### Add your composer github token before build

    export COMPOSER_GITHUB_TOKEN=foofoofoofoofoofoofoofoofoofoo
    echo $COMPOSER_GITHUB_TOKEN > composer.github.token
    echo "composer.github.token" >> .gitignore

### Using memcache

TODO: Add instructions

