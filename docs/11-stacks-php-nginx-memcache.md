Stacks - PHP/Nginx/Memcache
===================================

## Features

* Follows Docker's one-process-per-container philosophy by having separate containers for Nginx and PHP-FPM
* Uses official PHP-FPM and Nginx Docker containers
* Includes boilerplate configuration with Docker-specific enhancements
* (Optional) a PHP-FPM an Nginx server configuration generator for generating configuration based on your composer.json

## Installation

Clone/download a copy of this repository and copy the boilerplate files to your 12-factor app base dir.

Optionally, generation your project php/nginx base configuration: [Follow these instructions](../stacks/php-nginx-memcache/server-config-generator/README.md)

Add your project php/nginx configuration includes to the `stack/nginx/` and `stack/php/` directories.

## Usage

### Opening your local web app in the browser:

After running `docker-compose up`, you can find out the port your nginx container is responding on:

    export NGINX_PORT=$(docker-compose ps nginx | tail -n1 | awk '{ print $5 }' | sed 's/[0-9.]*://' | sed 's/->80\/tcp//')

Open http://$DOCKER_HOST_IP:$NGINX_PORT in your browser

### Useful general commands

Change and reload php configuration on-the-fly:

    docker-compose run phpfpm /bin/bash
    nano /usr/local/etc/php/php-fpm.ini
    kill -USR2 $(ps aux | grep 'php-fpm: master process' | grep -v grep | awk '{ print $2 }')

Change and reload nginx configuration on-the-fly:

    docker-compose run nginx /bin/bash
    nano /etc/nginx/nginx.conf
    nginx -s reload

### Using memcache

TODO: Add instructions