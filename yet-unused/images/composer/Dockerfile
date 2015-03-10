# Base docker image with
# -----------------------------------------------------
# Containers based on this image are supposed to be data volume containers with app source code.
# The /app directory is shared with the other containers in the stack as a volume.
# The base image (in this case debian:jessie) and packages installed are used only for installing
# app dependencies and other build tasks necessary to populate /app with the complete source code.
#
# Available on docker hub as neam/php-worker-base
#
# Build by running:
#     docker build -t 'neam/php-worker-base' .
#
# Replace with your own project tag in case you want to use a custom base image in your project.

FROM debian:jessie

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Update the below ENV date time to trigger docker to not used the cached apt system packages - general system packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-03-07 18:43"
RUN apt-get update && \
    apt-get upgrade -y -q

# Show available versions and install binaries used for composer installation during build
RUN apt-get install -y -q \
        git-core \
        php5-cli

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer && global asset plugin (a Yii 2.0 requirement)
ENV COMPOSER_HOME /root/.composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    /usr/local/bin/composer global require "fxp/composer-asset-plugin:1.0.*" && \
    /usr/local/bin/composer global dumpautoload --optimize
