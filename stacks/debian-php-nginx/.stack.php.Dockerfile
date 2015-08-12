# Project php docker image with source code
# --------------------------------

FROM neam/debian-php:5.6.9-fpm

# Add source code to /src
COPY . /app
