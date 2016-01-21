Docker-based Stack - Debian PHP/Nginx
===================================

## Features

* Follows Docker's one-process-per-container philosophy by having separate containers for Nginx and PHP-FPM
* Uses a Debian-derived PHP image and the official Nginx Docker image
* Includes boilerplate configuration with Docker-specific enhancements
* Includes both a PHP "ha" service which is not supposed to use any data volumes and thus can be scaled elastically, as well as a PHP "files" container which uses a /files volume to stored user-uploaded files 
* The PHP "ha" service is fronted by a HAProxy service that distributes the load to the PHP "ha" service containers
* The PHP services can use either PHP-FPM with Opcache (default) or HHVM
* Includes a PHP cli / shell container to run worker/administration commands locally - start a shell by running stack/shell.sh
* Includes the mailcatcher SMTP server for local development of mailing logic

## Default configuration

A frontend nginx location on / is configured to use the "ha" PHP service. A backend nginx location on /backend/ is configured to use the "files" PHP service. 

The frontend can be scaled horizontally and is thus served by different containers on each request, while the backend is always served by the same container. 

A Redis service is included in the docker stack and configured as the PHP session handler for all containers.

## Installation

Install docker-stack cli in your home directory and make it available in PATH when using bash: 

    git clone https://github.com/neam/docker-stack ~/.docker-stack
    git clone file:///Users/motin/Dev/Projects/neam/dna-project-base/components/composer-packages/docker-stack ~/.docker-stack
    echo 'export PATH=$PATH:~/.docker-stack/cli' >> ~/.bash_profile
    source ~/.bash_profile

Enter your project directory (can be an empty directory in case you simply want to try out the stack):

    mkdir myapp
    cd myapp

Then run the following commands to copy the boilerplate stack files to your 12-factor app base dir.

    docker-stack install neam/debian-php-nginx

## Usage

To try this stack out-of-the-box after installing it, you need a local `.env` where environment variables are specified which will be available to the PHP containers:

    echo 'FOO=bar' >> .env

Then, fire up the stack locally:

    docker-compose up -d

Visit the stack-hello pages by visiting the URL returned by:

    docker-stack local url web 80 - /stack-hello/

Or, create the index php files expected by the default configuration:

    mkdir -p frontend/www
    mkdir -p backend/www
    echo '<?php phpinfo();' > frontend/www/index.php
    echo '<?php phpinfo();' > backend/www/index.php

Visit the below returned urls in your browser:

    docker-stack local url
    docker-stack local url web 80 - /backend/

> Hint: On OSX, you can open the url directly from a terminal session:
>
>    open $(docker-stack local url)
>    open $(docker-stack local url web 80 - /backend/)

To scale the PHP "ha" service:

    docker-compose scale phpha=3

## Local Extras

The local stack include optional containers that emulate upstream services outside of your control. Simply comment them out if you do not need them.

### Explanation of the extra local containers

* `mailcatcher` - Runs a mailcatcher SMTP server

### Corresponding service in production

* `mailcatcher` - An SMTP service such as Gmail, Amazon Simple Mail Service, Foo etc

## Using mailcatcher

Configure your app to send emails using `mailcatcher` as the SMTP server against port 25.

The emails will show up in the web frontend accessible on the url given by the following command:

    docker-stack local url mailcatcher 1080

## Customization

### Configuration

Optionally, generate your project php/nginx base configuration based on composer.json metadata: [Follow these instructions](../../generators/server-config-generator/README.md)

Customize your php/nginx configuration by changing the files in your project's `stack/nginx/` and `stack/php/` directories.

To use PHP-FPM instead of HHVM, comment the "hhvm"-related lines almost at the bottom of your project's `stack/php/run.sh`, and uncomment the "php-fpm" line.

Also, because HHVM seems to alter the SCRIPT_NAME and DOCUMENT_ROOT params from nginx, add the following to your index.php file:

    // HHVM SCRIPT_NAME difference vs php-fpm workaround
    if (defined('HHVM_VERSION')) {
        $_SERVER['DOCUMENT_ROOT'] = $_SERVER['NGINX_DOCUMENT_ROOT'];
        $_SERVER['SCRIPT_NAME'] = $_SERVER['NGINX_SCRIPT_NAME'];
        $_SERVER['PHP_SELF'] = $_SERVER['NGINX_SCRIPT_NAME'];
    }

And make sure to keep the following in your nginx location blocks (see docker-stack/stacks/debian-php-nginx/stack/nginx/conf.d/app.conf):

    # for hhvm
    fastcgi_keep_conn on;
    fastcgi_param NGINX_SCRIPT_NAME $fastcgi_script_name;
    fastcgi_param NGINX_DOCUMENT_ROOT $document_root;

### Advanced

Compare this stack to the stack found at `../debian-php-nginx.dna-project-base` for an example of how to customize this stack for a specific project set-up