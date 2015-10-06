# Project php docker image with source code
# --------------------------------

FROM neam/dna-project-base-debian-php:5.6.13-fpm-0.4.0

# Add source code to /src
COPY . /app
