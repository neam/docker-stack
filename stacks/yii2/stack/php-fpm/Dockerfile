# Dockerfile for PHP-FPM built for Yii 2.0 Framework Applications
# ===============================================================

FROM php:5.6-fpm

MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system packages for PHP extensions
ENV IMAGE_FPM_APT_GET_DATE 2015-03-10-23-33
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
    && rm -r /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install intl \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install zip \
    && pecl install apcu-beta && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

EXPOSE 9000