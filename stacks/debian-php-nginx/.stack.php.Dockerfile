# Project php docker image with source code
# --------------------------------

FROM neam/debian-php:5.6.13-fpm

# Add source code to /src
COPY . /app
