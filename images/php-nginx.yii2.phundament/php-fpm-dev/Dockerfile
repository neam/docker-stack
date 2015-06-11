# Docker image for Phundament 4 applications
# ------------------------------------------
#
# FPM (dev)
#

FROM phundament/php:5.6-fpm-prod
MAINTAINER Tobias Munk <tobias@diemeisterei.de>
ENV IMAGE PHUNDAMENT_PHP_FPM_DEV

# Install extra development packages
WORKDIR /root
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        yui-compressor \
        nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm install -g less

ENV TRIGGER_CLOSURE_COMPILER 2015-06-08-23-20
RUN curl -o /root/compiler.tar.gz http://dl.google.com/closure-compiler/compiler-20150126.tar.gz && \
    tar -xzf /root/compiler.tar.gz && \
    rm /root/compiler.tar.gz

# install xdebug
RUN pecl install xdebug && \
    echo "zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_enable=0" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_autostart=0" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.idekey=PHPStorm" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "xdebug.extended_info=1" >> /usr/local/etc/php/conf.d/xdebug.ini
