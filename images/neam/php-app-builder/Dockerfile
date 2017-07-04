# Base image - PHP app builder
# -----------------------------------------------------
# Example/base "catch-all" php app builder image to use for installing app dependencies and running common build tasks
#
# Includes:
#  - Node.js 4.4
#  - Git (incl Git Flow and Git Svn)
#  - Mercurial
#  - Subversion
#  - Curl
#  - Wget
#  - Jq
#  - Yeoman
#  - Composer
#  - Bundler
#  - PHP with curl and mysql extensions
#  - and more (see below)
#
# Available on docker hub as neam/php-app-builder
#
# Build by running:
#     docker build -t neam/php-app-builder .
#     docker push neam/php-app-builder
#
# Replace with your own project tag to build and push a custom base image for use in your project.

FROM debian:jessie

# defaults, use other values at build-time to produce an image with other versions
ARG PHP_PACKAGE_NAME_VERSION=5

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# PHP 7 sources
RUN if [ "${PHP_PACKAGE_NAME_VERSION}" = "7.0" ]; then \
      echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.org.list && \
      echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list.d/dotdeb.org.list && \
      apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
      gpg --keyserver keys.gnupg.net --recv-key 89DF5277 && \
      gpg -a --export 89DF5277 | apt-key add -; fi

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2017-07-03 16:26

# Enable editors and general tools for administration processes
ENV TERM xterm
RUN apt-get install -y -q \
        curl \
        wget \
        htop \
        less \
        jq \
        nano \
        sed \
        telnet \
        net-tools \
        vim

# Install Node.js and npm for installation of dependencies during build (Note: runs apt-get update)
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
  echo "nodejs \n $(apt-cache show nodejs | grep -i version)" && \
  apt-get install -y nodejs=4.8.*

# Version control systems
RUN apt-get install -y -q \
        git-flow \
        git-svn \
        mercurial \
        subversion

# Clojure compiler
ENV IMAGE_CLI_CLOSURE_COMPILER 2015-03-10-23-33
RUN curl -o /root/compiler.tar.gz http://dl.google.com/closure-compiler/compiler-20150126.tar.gz && \
    tar -xzf /root/compiler.tar.gz && \
    rm /root/compiler.tar.gz

# Build essential is necessary to compile some binary dependencies
RUN apt-get install build-essential -y -q

# Yeoman - Yo, Grunt, Gulp, Bower, Coffee Script
RUN npm install -g yo grunt-cli bower coffee-script
RUN npm install -g gulp

# Install PHP with curl & mysql
RUN apt-get install -y -q \
        php${PHP_PACKAGE_NAME_VERSION}-cli \
        php${PHP_PACKAGE_NAME_VERSION}-curl \
        php${PHP_PACKAGE_NAME_VERSION}-mysql

# For bundler and erb templates
RUN apt-get install -y -q \
        ruby-full

# Bundler
RUN gem install bundler

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer && global asset plugin (a Yii 2.0 requirement)
ENV COMPOSER_HOME /root/.composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    /usr/local/bin/composer global require "fxp/composer-asset-plugin:~1.1.1" && \
    /usr/local/bin/composer global dumpautoload --optimize
