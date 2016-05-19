# Project php docker image with source code
# --------------------------------

FROM neam/debian-php:fpm-5.6.20-hhvm-3.12.0-for-debian-php-nginx-stack

# Add source code to /src
COPY . /app
