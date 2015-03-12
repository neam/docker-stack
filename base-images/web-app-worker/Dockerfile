# Base image - Web app worker
# -----------------------------------------------------
# Example/base "catch-all" web app worker image to use to run administration processes in production deployments
#
# Includes:
#  - MySQL Client
#  - S3cmd
#  - Curl
#  - Wget
#  - Jq
#  - and more (see below)
#
# Available on docker hub as neam/web-app-worker
#
# Build by running:
#     docker build -t neam/web-app-worker .
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
ENV APT_DOCKER_CACHE_TRIGGER "2015-03-12 03:18"
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

# Database clients
RUN apt-get install -y -q \
        mysql-client

# Add external apt repositories
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.5.0* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
