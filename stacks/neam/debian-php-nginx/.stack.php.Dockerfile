# Project php docker image with source code
# --------------------------------

FROM neam/debian-php:fpm-7.0.27-hhvm-3.x.y-for-debian-php-nginx-stack

# Add source code to /src
COPY . /app
