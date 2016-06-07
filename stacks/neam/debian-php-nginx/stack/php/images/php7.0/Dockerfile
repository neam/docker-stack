# Dockerfile for PHP (FPM 5.6.20, HHVM 3.13.1) built for Debian PHP/Nginx base docker-stack
# ===============================================================
#   docker build -t neam/debian-php:fpm-7.0.7-hhvm-3.13.1-for-debian-php-nginx-stack .
#   docker push neam/debian-php:fpm-7.0.7-hhvm-3.13.1-for-debian-php-nginx-stack

FROM neam/debian-php:fpm-7.0.7-hhvm-3.13.1
ARG PHP_PACKAGE_NAME_VERSION=7.0

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-06-07 07:33

# Install PHP extensions available via apt-get (required for PHP-FPM, but can also be useful to HHVM since default configurations for the extensions are incorporated in the docker image)
RUN apt-get install -y -q \
        php${PHP_PACKAGE_NAME_VERSION}-xdebug \
        php${PHP_PACKAGE_NAME_VERSION}-intl \
        php${PHP_PACKAGE_NAME_VERSION}-gd \
        php${PHP_PACKAGE_NAME_VERSION}-mysql \
        php${PHP_PACKAGE_NAME_VERSION}-sqlite \
        php${PHP_PACKAGE_NAME_VERSION}-mcrypt \
        php${PHP_PACKAGE_NAME_VERSION}-curl \
        php${PHP_PACKAGE_NAME_VERSION}-memcached \
        php${PHP_PACKAGE_NAME_VERSION}-redis \
        php${PHP_PACKAGE_NAME_VERSION}-mongo \
        php${PHP_PACKAGE_NAME_VERSION}-xsl \
        php${PHP_PACKAGE_NAME_VERSION}-apcu && \
        phpenmod mcrypt

# For compilation of php 7 extensions
#RUN apt-get install -y -q \
#        php7.0-dev
#
# Ice for PHP extension - does not work on PHP 7
#RUN wget https://github.com/ice/framework/archive/1.0.36.zip && \
#        unzip 1.0.36.zip && \
#        cd framework-1.0.36 && \
#        ./install && \
#        cd .. && \
#        rm -r framework-1.0.36#
#
#RUN echo "[ice]\nextension = ice.so" | tee /etc/php/7.0/mods-available/ice.ini && phpenmod ice

# ====
# Install enough to be able to run administrative commands directly from within the php containers
# Useful when using docker exec to emulate the ability to SSH into running containers
# ====

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

# Version control systems
RUN apt-get install -y -q \
        git-flow \
        git-svn \
        mercurial \
        subversion

# Database clients
RUN apt-get install -y -q \
        mysql-client

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
