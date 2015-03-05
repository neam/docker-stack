Docker PHP Toolkit
=================================

Toolkit for maintaining a Docker-based "one-process-per-container" PHP-FPM/Nginx stack for 12-factor PHP apps.

Includes:
 * Boilerplate files to include in your 12-factor app
 * PHP-FPM an Nginx server configuration generator for generating configuration based on your composer.json
 * The Dockerfile for the `neam/docker-php-toolkit-app-source-code-container-base` image
 * Some potentially useful shell scripts

## Installation

Copy boilerplate files to your 12-factor app base dir.

Add the following to the require section of your composer.json:

    "neam/docker-php-toolkit": "dev-develop"

Add your project php/nginx configuration includes to the `server-config/*/conf.d/` directories.

Your configuration files may use the following style of placeholders to include the value of environment variables at runtime:

    fastcgi_pass ${PHPFPM_PORT_9000_TCP_ADDR}:${PHPFPM_PORT_9000_TCP_PORT};

## Generate general project nginx configuration based on composer.json

Optionally, add server configuration to your composer.json under the key "extra.server-config".

Example:

    "extra": {
        "server-config": {
            "framework": "yii-dna",
            "engines": {
                "php": "5.5.15",
                "nginx": "1.4.4"
            },
            "php-config": [
                "upload_max_filesize=200M",
                "post_max_size=200M",
                "max_execution_time=60",
                "xdebug.default_enable=off",
                "newrelic.logfile=/var/log/newrelic.log",
                "error_log=/var/log/error.log",
                "error_reporting=E_ALL",
                "html_errors=on",
                "display_errors=on",
                "short_open_tag=on"
            ],
            "document-root": "webapps/external-angular-frontend",
            "index-document": "index.php",
            "nginx-locations": [
                {
                    "location": "/api/",
                    "document-root": "yiiapps/rest-api/www",
                    "memcached-key-prefix": "api",
                    "nginx-includes": [
                        "vendor/neam/yii-dna-deployment/nginx-buildpack-custom-configuration.conf"
                    ]
                }
            ],
            "newrelic": false,
            "log-files": [
                "yiiapps/rest-api/app/runtime/application.log",
                "yiiapps/rest-api/app/runtime/application.log",
                "/var/log/newrelic.log",
                "/var/log/error.log",
            ]
        }
    },

Then generate php and nginx config:

    export APP_DIR=$(pwd)
    vendor/neam/docker-php-toolkit/server-config-generator/parse-composer-json.sh
    vendor/neam/docker-php-toolkit/server-config-generator/generate-nginx-config.sh
    vendor/neam/docker-php-toolkit/server-config-generator/generate-php-config.sh

# Usage

1. Build, tag and push your project source code docker image
2. Update docker-compose.yml to use the correct docker image tag
3. Deploy

# Deploy on a docker host

Git clone your project anywhere on the docker host, then run:

    docker-compose up

# Deploy on Tutum

    TODO

