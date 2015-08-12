# Project php docker image with source code
# --------------------------------

FROM neam/dna-project-base-debian-php:5.6.9-fpm-0.2.2

# Add source code to /src
COPY . /app
