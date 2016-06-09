# Dockerfile for PHP (FPM 5.6.20, HHVM 3.13.1) built for Debian PHP/Nginx base docker-stack
# ===============================================================
#   docker build -t neam/debian-php:fpm-5.6.20-hhvm-3.13.1-for-debian-php-nginx-stack .
#   docker push neam/debian-php:fpm-5.6.20-hhvm-3.13.1-for-debian-php-nginx-stack

FROM neam/debian-php:fpm-5.6.20-hhvm-3.13.1
ARG PHP_PACKAGE_NAME_VERSION=5

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-06-07 07:33

# Install PHP extensions available via apt-get (required for PHP-FPM, but can also be useful to HHVM since default configurations for the extensions are incorporated in the docker image)
RUN apt-get install -y -q \
        php${PHP_PACKAGE_NAME_VERSION}-xdebug \
        php${PHP_PACKAGE_NAME_VERSION}-intl \
        php${PHP_PACKAGE_NAME_VERSION}-gd \
        php${PHP_PACKAGE_NAME_VERSION}-mysqlnd \
        php${PHP_PACKAGE_NAME_VERSION}-sqlite \
        php${PHP_PACKAGE_NAME_VERSION}-mcrypt \
        php${PHP_PACKAGE_NAME_VERSION}-curl \
        php${PHP_PACKAGE_NAME_VERSION}-memcached \
        php${PHP_PACKAGE_NAME_VERSION}-redis \
        php${PHP_PACKAGE_NAME_VERSION}-mongo \
        php${PHP_PACKAGE_NAME_VERSION}-xsl \
        php${PHP_PACKAGE_NAME_VERSION}-apcu

# Install PHP mongodb support - https://github.com/mongodb/mongo-php-driver
#RUN pecl install mongodb
#RUN echo "extension=mongodb.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"`

# Install HHVM mongodb support - https://github.com/mongodb/mongo-php-driver
#hhvm-dev
#mkdir hhvm-mongodb \
#cd hhvm-mongodb \
#wget ...
#tar -xvzf ../hhvm-mongodb-1.0alpha1.tgz \
#cd hhvm-mongodb-1.0alpha1 \
#hphpize \
#cmake . \
#make configlib \
#make -j 16 \
#make install
#/etc/hhvm/php.ini
#hhvm.dynamic_extensions[mongodb]=mongodb.so

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
