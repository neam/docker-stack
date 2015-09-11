# Dockerfile for PHP-CLI built for Yii 2.0 Framework Applications
# ===============================================================

FROM php:5.6-cli
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system packages for PHP extensions required for Yii 2.0 Framework
RUN apt-get update && \
    apt-get -y install \
            g++ \
            git \
            libicu-dev \
            libmcrypt-dev \
            libfreetype6-dev \
            libjpeg62-turbo-dev \
            libmcrypt-dev \
            libpng12-dev \
            zlib1g-dev \
        --no-install-recommends && \
    rm -r /var/lib/apt/lists/* # 150901

# Install PHP extensions required for Yii 2.0 Framework
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ && \
    docker-php-ext-install gd
RUN docker-php-ext-install intl \
                           pdo_mysql \
                           mbstring \
                           mcrypt \
                           zip
RUN pecl install apcu-beta && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

# Include composer and application binaries in PATH
ENV PATH /app:/app/vendor/bin:/root/.composer/vendor/bin:$PATH
# Persist composer caches
VOLUME /root/.composer
# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.0.0-alpha10 && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require "fxp/composer-asset-plugin:1.0.*" && \
    composer global dumpautoload --optimize
