# Dockerfile for PHP (FPM 5.6.14, HHVM 3.11.0) built for PHP/Nginx-based docker-stacks
# ===============================================================
#   docker build -f Dockerfile -t neam/debian-php:fpm-5.6.14-hhvm-3.11.0 .
#   docker push neam/debian-php:fpm-5.6.14-hhvm-3.11.0

FROM debian:jessie

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# For HHVM binaries
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
RUN echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-01-07 13:16

# Install specific version of PHP-FPM (if not available - show what versions were available in debian jessie at the moment of APT_DOCKER_CACHE_TRIGGER above)
RUN apt-get install -y -q \
        php5-fpm=5.6.14* \
  || (echo "php5-cli \n $(apt-cache show php5-cli | grep -i version)" && \
      echo "php5-fpm \n $(apt-cache show php5-fpm | grep -i version)" && \
      exit 1)

# HHVM binaries
RUN apt-get install -y -q \
        hhvm=3.11.0* \
  || (echo "hhvm \n $(apt-cache show hhvm | grep -i version)" && \
      exit 1)

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
