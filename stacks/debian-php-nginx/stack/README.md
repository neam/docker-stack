Stacks - Debian PHP/Nginx
===================================

## Features

* Follows Docker's one-process-per-container philosophy by having separate containers for Nginx and PHP-FPM
* Uses a Debian-derived PHP-FPM container and the official Nginx Docker containers
* Includes boilerplate configuration with Docker-specific enhancements

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

Also, you need the local files directory and the DATA environment variable to indicate where local files are stored:

    mkdir -p .files/foo/media
    echo 'DATA=foo' >> .env

Fire up the stack locally:

    docker-compose up -d

Visit the below returned url in your browser:

    docker-stack local url

> Hint: On OSX, you can open the url directly from a terminal session:
>
>    open $(docker-stack local url)

