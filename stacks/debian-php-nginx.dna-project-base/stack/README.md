Stacks - PHP/Nginx/Memcache - DNA Project Base
===================================

## Features

* Follows Docker's one-process-per-container philosophy by having separate containers for Nginx and PHP-FPM
* Uses a Debian-derived PHP-FPM container and the official Nginx Docker containers
* Includes boilerplate configuration with Docker-specific enhancements
* Includes both a PHP "files" container which uses a /files volume for stored user-uploaded files, and a PHP "ha" container which is not supposed to use any data volumes and thus can be scaled elastically
* Compatible with deployment routines explained in [https://github.com/neam/yii-dna-deployment](https://github.com/neam/yii-dna-deployment)

## Default configuration

A frontend nginx location on / is configured to use the "ha" PHP service. A backend nginx location on /backend/ is configured to use the "files" PHP service. 

The frontend can be scaled horizontally and is thus served by different containers on each request, while the backend is always served by the same container. 

A Redis service is included in the docker stack and configured as the PHP session handler for all containers. 

## Installation

Clone/download a copy of this repository and copy the boilerplate files to your 12-factor app base dir.

    cd my-app
    docker-stack install debian-php-nginx
    docker-stack install debian-php-nginx.dna-project-base

Optionally, generation your project php/nginx base configuration: [Follow these instructions](../../generators/server-config-generator/README.md)

Add your project php/nginx configuration includes to the `stack/nginx/` and `stack/php/` directories.

## Usage

To try this stack out-of-the-box after installing it, create the index php files expected by the default configuration:

    mkdir -p frontend/www
    mkdir -p backend/www
    echo '<?php phpinfo();' > frontend/www/index.php
    echo '<?php phpinfo();' > backend/www/index.php

Also, you need the local files directory and the DATA environment variable to indicate where local files are stored:

    mkdir -p .files/foo/media
    echo 'DATA=foo' >> .env

Fire up the stack locally:

    docker-compose up -d

Visit the below returned urls in your browser:

    docker-stack local url
    docker-stack local url /backend/

> Hint: On OSX, you can open the url directly from a terminal session:
>
>    open $(docker-stack local url)
>    open $(docker-stack local url /backend/)

To scale the PHP "ha" service:

    docker-compose scale phpha=3

## Local Extras

The local stack include optional containers that emulate upstream services outside of your control. Simply comment them out if you do not need them.

### Explanation of the extra local containers

* (TODO) `db` - Runs a local MariaDB docker container with persistent data
* `mailcatcher` - Runs a mailcatcher SMTP server

### Corresponding services in production

* (TODO) `db` - A cloud database service such as Amazon RDS, Rackspace Cloud DB, ClearDB etc
* `mailcatcher` - An SMTP service such as Gmail, Amazon Simple Mail Service, Foo etc

### Using memcache

TODO: Add instructions

