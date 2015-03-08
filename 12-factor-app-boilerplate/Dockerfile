# Project source code data volume container docker image
# --------------------------------
# This builds a data volume containers with the app source code.
# The /app directory is shared with the other containers in the stack as a volume.
# The base image (in this case debian:jessie) and packages installed there are used only for installing
# app dependencies and other build tasks necessary to populate /app with the complete source code.
#
# Build by running:
#     docker build -t 'user/project' .
#
# Replace with your own project tag.

FROM neam/dpt-project-data-container:latest

# Add composer github token for faster downloads
COPY composer.github.token composer.github.token
RUN /usr/local/bin/composer config -g github-oauth.github.com "$(cat composer.github.token)" --no-interaction

# Run project-specific installation of dependencies (put the ones most likely to change at the bottom in order to re-use as many image layers as possible)

WORKDIR /app/
COPY composer.lock /app/composer.lock
COPY composer.json /app/composer.json
RUN /usr/local/bin/composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction --ignore-platform-reqs

# Add source code to volume mount point
COPY . /app

# Env var with path to application directory
ENV APP_DIR /app
