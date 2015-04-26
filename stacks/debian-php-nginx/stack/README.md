Stacks - Debian PHP/Nginx
===================================

## Features

* Follows Docker's one-process-per-container philosophy by having separate containers for Nginx and PHP-FPM
* Uses a Debian-derived PHP-FPM container and the official Nginx Docker containers
* Includes boilerplate configuration with Docker-specific enhancements
* Includes both a PHP "files" container which uses a /files volume for stored user-uploaded files, and a PHP "ha" container which is not supposed to use any data volumes and thus can be scaled elastically

## Installation

Clone/download a copy of this repository and copy the boilerplate files to your 12-factor app base dir.

    cd my-app
    docker-stack install debian-php-nginx

Optionally, generation your project php/nginx base configuration: [Follow these instructions](../../generators/server-config-generator/README.md)

Add your project php/nginx configuration includes to the `stack/nginx/` and `stack/php/` directories.

## Usage

To try this stack out-of-the-box after installing it, create the index php file expected by the default configuration:

    mkdir -p foo/www
    echo '<?php phpinfo();' > foo/www/index.php

Also, you need a local `.env` where environment variables are specified which will be available to the PHP containers:

    echo 'FOO=bar' >> .env

Fire up the stack locally:

    docker-compose up -d

Visit the below returned url in your browser:

    docker-stack local url

> Hint: On OSX, you can open the url directly from a terminal session:
>
>    open $(docker-stack local url)

To scale the PHP "ha" service:

    docker-compose scale phpha=3
