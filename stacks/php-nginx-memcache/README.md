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
    cp -r docker-stack/stacks/php-nginx-memcache/boilerplate/* .

Optionally, generation your project php/nginx base configuration: [Follow these instructions](../stacks/php-nginx-memcache/server-config-generator/README.md)

Add your project php/nginx configuration includes to the `stack/nginx/` and `stack/php/` directories.

## Usage

### Opening your local web app in the browser:

After running `docker-compose up`, you can find out the url your nginx container is responding on:

    stack/nginx/url.sh

On OS X you can even open the url directly from your terminal:

    open $(stack/nginx/url.sh)

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

## Local Extras

The local stack include optional containers that emulate upstream services outside of your control. Simply comment them out if you do not need them.

### Explanation of the extra local containers

* `db` - Runs a local MariaDB docker container with persistent data
* `mailcatcher` - Runs a mailcatcher SMTP server
* `proxy` - Runs a nginx reverse proxy using the configuration found in `project root``/../proxy`.

### Corresponding services in production

* `db` - A cloud database service such as Amazon RDS, Rackspace Cloud DB, ClearDB etc
* `mailcatcher` - An SMTP service such as Gmail, Amazon Simple Mail Service, Foo etc
* `proxy` - A reverse proxy or other routing layer on the server(s) that your public DNS is connected to
