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
#     docker build -t neam/php-app-worker:debian-jessie .
#     docker push neam/php-app-worker:debian-jessie
#
# Replace with your own project tag to build and push a custom base image for use in your project.

FROM debian:jessie
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
    apt-get upgrade -y -q # 2016-06-07 07:33

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
  apt-get install -y nodejs=4.4.*

# Version control systems
RUN apt-get install -y -q \
        git-flow \
        git-svn \
        mercurial \
        subversion

# Database clients
RUN apt-get install -y -q \
        mysql-client

# Install PHP with curl & mysql
RUN apt-get install -y -q \
        php${PHP_PACKAGE_NAME_VERSION}-cli \
        php${PHP_PACKAGE_NAME_VERSION}-curl \
        php${PHP_PACKAGE_NAME_VERSION}-mysql

# For erb templates
RUN apt-get install -y -q \
        ruby-full

# Add external apt repositories
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.5.0* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
