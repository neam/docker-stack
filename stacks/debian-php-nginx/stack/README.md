Docker-based Stack - Debian PHP/Nginx
===================================

## Features

* Follows Docker's one-process-per-container philosophy by having separate containers for Nginx and PHP-FPM
* Uses a Debian-derived PHP image and the official Nginx Docker image
* Includes boilerplate configuration with Docker-specific enhancements
* Includes both a PHP "ha" service which is not supposed to use any data volumes and thus can be scaled elastically, as well as a PHP "files" container which uses a /files volume to stored user-uploaded files 
* The PHP "ha" service is frontend by a HAProxy service that distributes the load to the PHP "ha" service containers
* The PHP service can use either PHP-FPM with Opcache (default) or HHVM

## Default configuration

A frontend nginx location on / is configured to use the "ha" PHP service. A backend nginx location on /backend/ is configured to use the "files" PHP service. 

The frontend can be scaled horizontally and is thus served by different containers on each request, while the backend is always served by the same container. 

A Redis service is included in the docker stack and configured as the PHP session handler for all containers.

## Installation

Clone/download a copy of this repository and copy the boilerplate files to your 12-factor app base dir.

    cd my-app
    docker-stack install debian-php-nginx

## Usage

To try this stack out-of-the-box after installing it, create the index php files expected by the default configuration:

    mkdir -p frontend/www
    mkdir -p backend/www
    echo '<?php phpinfo();' > frontend/www/index.php
    echo '<?php phpinfo();' > backend/www/index.php

Also, you need a local `.env` where environment variables are specified which will be available to the PHP containers:

    echo 'FOO=bar' >> .env

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

## Customization

### Configuration

Optionally, generate your project php/nginx base configuration based on composer.json metadata: [Follow these instructions](../../generators/server-config-generator/README.md)

Customize your php/nginx configuration by changing the files in your project's `stack/nginx/` and `stack/php/` directories.

To use HHVM instead of PHP-FPM, comment the "php-fpm" command almost at the bottom of your project's `stack/php/run.sh`, and uncomment the "hhvm" command. 

### Advanced

Compare this stack to the stack found at `../debian-php-nginx.dna-project-base` for an example of how to customize this stack for a specific project set-up
