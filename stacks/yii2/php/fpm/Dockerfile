# Dockerfile for PHP-FPM built for Yii 2.0 Framework Applications
# ===============================================================

FROM php:5.6-fpm

MAINTAINER Tobias Munk <tobias@diemeisterei.de>

RUN apt-get update \
    && apt-get -y install \
            g++ \
            git \
            libicu-dev \
            libmcrypt-dev \
            libfreetype6-dev \
            libjpeg62-turbo-dev \
            libmcrypt-dev \
            libpng12-dev \
            zlib1g-dev \
        --no-install-recommends \
    && rm -r /var/lib/apt/lists/* \

    # Install PHP extensions
    && docker-php-ext-install intl \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install zip \
    && pecl install apcu-beta && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

    # Install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require "fxp/composer-asset-plugin:1.0.0"

# Fix write permissions with shared folders
# usermod -u 1000 www-data

# /!\ DEVELOPMENT ONLY SETTINGS /!\
# Running PHP-FPM as root, required for volumes mounted from host
#RUN sed -i.bak 's/user = www-data/user = root/' /etc/php5/fpm/pool.d/www.conf && \
#    sed -i.bak 's/group = www-data/group = root/' /etc/php5/fpm/pool.d/www.conf && \
#    sed -i.bak 's/--fpm-config /-R --fpm-config /' /etc/init.d/php5-fpm
# /!\ DEVELOPMENT ONLY SETTINGS /!\
