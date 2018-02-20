# Project php docker image with source code
# --------------------------------

FROM neam/dna-project-base-debian-php:1.0.0

# Add source code to /src
COPY . /app
