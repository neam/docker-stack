Docker PHP Toolkit - Server Config Generator
============================================

Reads composer.json and generates PHP-FPM and Nginx configuration based on project requirements

# Generate general project php+nginx configuration based on composer.json

Add server configuration to your composer.json under the key "extra.server".

Example:

    "extra": {
        "server": {
            "framework": "yii-dna",
            "engines": {
                "php": "5.5.15",
                "nginx": "1.4.4"
            },
            "php-config": [
                "upload_max_filesize=200M",
                "post_max_size=200M",
                "memory_limit=128M",
                "max_execution_time=60",
                "xdebug.default_enable=off",
                "newrelic.logfile=/var/log/newrelic.log",
                "error_reporting=E_ALL",
                "html_errors=on",
                "display_errors=${DISPLAY_PHP_ERRORS}",
                "short_open_tag=on"
            ],
            "document-root": "ui/frontend/web",
            "index-document": "index.php",
            "memcached-key-prefix": "frontend",
            "nginx-includes": [
                "stack/nginx/include/location-defaults.conf"
            ],
            "nginx-locations": [
                {
                    "location": "/api/",
                    "document-root": "external-apis/rest-api/www",
                    "index-document": "index.php",
                    "memcached-key-prefix": "api",
                    "nginx-includes": [
                        "stack/nginx/include/location-defaults.conf"
                    ]
                }
            ],
            "newrelic": false,
            "log-files": [
                "ui/frontend/app/runtime/application.log",
                "external-apis/rest-api/app/runtime/application.log",
                "/var/log/newrelic.log",
                "/var/log/error.log",
            ]
        }
    },

Build the server-config-generator image:

    docker build -t 'server-config-generator' vendor/neam/docker-stack/stacks/php-nginx-memcache/server-config-generator/

Then generate php and nginx config:

    docker run -v $(pwd):/app server-config-generator /generator/parse-composer-json.sh
    docker run -v $(pwd):/app server-config-generator /generator/generate-nginx-config.sh
    docker run -v $(pwd):/app server-config-generator /generator/generate-php-config.sh
