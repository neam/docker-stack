# Project php docker image with source code
# --------------------------------

FROM neam/debian-php:fpm-5.6.30-hhvm-3.20.2-for-debian-php-nginx-stack

# Add source code to /src
COPY . /app
