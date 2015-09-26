# Base image - PHP app worker
# -----------------------------------------------------
# Example/base "catch-all" php app worker image to use to run administration processes in production deployments
#
# Includes:
#  - Node.js 0.10
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

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Update the below ENV date time to trigger docker to not used the cached apt system packages - general system packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-09-26 13:22"
RUN apt-get update && \
    apt-get upgrade -y -q

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
        vim

# Install Node.js and npm for installation of dependencies during build (Note: runs apt-get update)
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
  echo "nodejs \n $(apt-cache show nodejs | grep -i version)" && \
  apt-get install -y nodejs=0.10.*

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
        php5-cli \
        php5-curl \
        php5-mysql

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
