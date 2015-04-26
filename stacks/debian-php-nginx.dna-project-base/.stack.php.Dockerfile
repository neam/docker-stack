# Project php docker image with source code
# --------------------------------

FROM neam/dna-project-base-debian-php:5.6.7-fpm-0.2.0

# Add source code to /src
COPY . /app
