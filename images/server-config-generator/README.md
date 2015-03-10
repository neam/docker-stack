Docker PHP Toolkit - Server Config Generator
============================================

Reads composer.json and generates PHP-FPM and Nginx configuration based on project requirements

# Generate general project php+nginx configuration based on composer.json

Add server configuration to your composer.json under the key "extra.server-config".

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
    docker-compose run -it docker-php-toolkit/generator server-config/parse-composer-json.sh
    docker-compose run -it docker-php-toolkit/generator server-config/generate-nginx-config.sh
    docker-compose run -it docker-php-toolkit/generator server-config/generate-php-config.sh
