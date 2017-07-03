# Dockerfile for PHP (FPM 5.6.20, HHVM 3.13.1) built for PHP/Nginx-based docker-stacks
# ===============================================================
#   docker build -f Dockerfile -t neam/debian-php:fpm-5.6.20-hhvm-3.13.1 .
#   docker push neam/debian-php:fpm-5.6.20-hhvm-3.13.1

FROM debian:jessie

# defaults, use other values at build-time to produce an image with other versions
ARG PHP_VERSION=5.6.20
ARG PHP_PACKAGE_NAME_VERSION=5
ARG HHVM_VERSION=3.13.1

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# For HHVM binaries
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 && \
      echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list

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

# Install specific version of PHP-FPM (if not available - show what versions were available in debian jessie at the moment of APT_DOCKER_CACHE_TRIGGER above)
RUN apt-get install -y -q \
        php${PHP_PACKAGE_NAME_VERSION}-fpm=${PHP_VERSION}* \
  || (echo "php${PHP_PACKAGE_NAME_VERSION}-cli \n $(apt-cache show php${PHP_PACKAGE_NAME_VERSION}-cli | grep -i version)" && \
      echo "php${PHP_PACKAGE_NAME_VERSION}-fpm \n $(apt-cache show php${PHP_PACKAGE_NAME_VERSION}-fpm | grep -i version)" && \
      exit 1)

# HHVM binaries
RUN apt-get install -y -q \
        hhvm=${HHVM_VERSION}* \
  || (echo "hhvm \n $(apt-cache show hhvm | grep -i version)" && \
      exit 1)

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set environment var PHP_PACKAGE_NAME_VERSION
ENV PHP_PACKAGE_NAME_VERSION ${PHP_PACKAGE_NAME_VERSION}
