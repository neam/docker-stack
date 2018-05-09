# Dockerfile for PHP (FPM 7.0.27, HHVM 3.x.y) built for PHP/Nginx-based docker-stacks
# ===============================================================
#   docker build -f Dockerfile -t neam/debian-php:fpm-7.0.27-hhvm-3.x.y .
#   docker push neam/debian-php:fpm-7.0.27-hhvm-3.x.y

FROM debian:stretch

# defaults, use other values at build-time to produce an image with other versions
ARG PHP_VERSION=7.0.27
ARG PHP_PACKAGE_NAME_VERSION=7.0
ARG HHVM_VERSION=3.x.y

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2018-05-09 19:40

# PHP 7.1 sources
RUN if [ "${PHP_PACKAGE_NAME_VERSION}" = "7.1" ]; then \
      apt-get install -y -q apt-transport-https lsb-release ca-certificates curl && \
      curl -L -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
      sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
      apt-get update; fi

# PHP 7.2 sources
RUN if [ "${PHP_PACKAGE_NAME_VERSION}" = "7.2" ]; then \
      apt-get install -y -q apt-transport-https lsb-release ca-certificates curl && \
      curl -L -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
      sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' && \
      apt-get update; fi

# Install specific version of PHP-FPM (if not available - show what versions were available in debian stretch at the moment of APT_DOCKER_CACHE_TRIGGER above)
RUN apt-get install -y -q \
        php${PHP_PACKAGE_NAME_VERSION}-fpm=${PHP_VERSION}* \
  || (echo "php${PHP_PACKAGE_NAME_VERSION}-cli \n $(apt-cache show php${PHP_PACKAGE_NAME_VERSION}-cli | grep -i version)" && \
      echo "php${PHP_PACKAGE_NAME_VERSION}-fpm \n $(apt-cache show php${PHP_PACKAGE_NAME_VERSION}-fpm | grep -i version)" && \
      exit 1)

# HHVM binaries
#RUN apt-get install -y -q \
#        hhvm=${HHVM_VERSION}* \
#  || (echo "hhvm \n $(apt-cache show hhvm | grep -i version)" && \
#      exit 1)

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set environment var PHP_PACKAGE_NAME_VERSION
ENV PHP_PACKAGE_NAME_VERSION ${PHP_PACKAGE_NAME_VERSION}
