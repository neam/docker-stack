# Base image - PHP app worker
# -----------------------------------------------------
# Example/base "catch-all" php app worker image to use to run administration processes in production deployments
#
# Includes:
#  - Node.js 4.4
#  - Git (incl Git Flow and Git Svn)
#  - Mercurial
#  - Subversion
#  - MySQL Client
#  - S3cmd
#  - Curl
#  - Wget
#  - Jq
#  - PHP with curl and mysql extensions
#  - and more (see below)
#
# Available on docker hub as neam/php-app-worker
#
# Build by running:
#     docker build -t neam/php-app-worker .
#     docker push neam/php-app-worker
#
# Replace with your own project tag to build and push a custom base image for use in your project.

FROM debian:stretch

# defaults, use other values at build-time to produce an image with other versions
ARG PHP_PACKAGE_NAME_VERSION=7.0

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2017-08-24 17:34

# Enable editors and general tools for administration processes
ENV TERM xterm
RUN apt-get install -y -q \
        curl \
        wget \
        gnupg \
        htop \
        less \
        jq \
        nano \
        man-db \
        lsb-release \
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

# Database clients
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.6-1_all.deb && \
        dpkg -i mysql-apt-config_0.8.6-1_all.deb && \
        rm mysql-apt-config_0.8.6-1_all.deb && \
        apt-get update && \
        apt-get install -y -q \
        mysql-client

# PHP 7.1 sources
RUN if [ "${PHP_PACKAGE_NAME_VERSION}" = "7.1" ]; then \
      apt-get install -y -q apt-transport-https lsb-release ca-certificates curl && \
      curl -L -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
      sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
      apt-get update; fi

# Install PHP cli with curl, xml & mysql extensions
RUN apt-get install -y -q \
        php${PHP_PACKAGE_NAME_VERSION}-cli \
        php${PHP_PACKAGE_NAME_VERSION}-curl \
        php${PHP_PACKAGE_NAME_VERSION}-xml \
        php${PHP_PACKAGE_NAME_VERSION}-mysqlnd

# For erb templates
RUN apt-get install -y -q \
        ruby-full

# Add external apt repositories
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.6.1* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Install pipe viewer (pv) to monitor progress of commands that pipes large files
RUN apt-get install -y -q pv

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
