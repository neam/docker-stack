# Base docker image for a PHP 12-factor app source code container
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

# Enable editors and useful tools to include in base image
ENV TERM xterm
RUN apt-get install -y -q \
        curl \
        wget \
        htop \
        less \
        jq \
        nano \
        sed \
        vim

# Show available versions and install binaries used for composer installation during build
RUN apt-get install -y -q \
        git-core \
        php5-cli

# Add external apt repositories
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list

# Install Node.js and npm for installation of dependencies during build (Note: runs apt-get update)
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
  echo "nodejs \n $(apt-cache show nodejs | grep -i version)" && \
  apt-get install -y nodejs=0.10.*

# Install s3cmd
RUN echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && \
  apt-get install -y -q s3cmd=1.0.0*

# Clojure compiler
#

# sdfjklsdf
sdljkf
sdfkljsdf
ljksdflkjsdf
kljsdfjlksdf

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer && global asset plugin (a Yii 2.0 requirement)
ENV COMPOSER_HOME /root/.composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    /usr/local/bin/composer global require "fxp/composer-asset-plugin:1.0.*" && \
    /usr/local/bin/composer global dumpautoload --optimize
