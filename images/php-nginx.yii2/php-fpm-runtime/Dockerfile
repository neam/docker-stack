# Dockerfile for PHP-FPM built for Yii 2.0 Framework Applications
# ===============================================================

FROM schmunk42/php:5.6-fpm
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system packages for PHP extensions required for Yii 2.0 Framework
ENV IMAGE_PHPFPM_APT_GET_DATE 2015-03-10-23-33
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
    rm -r /var/lib/apt/lists/*

# Install PHP extensions required for Yii 2.0 Framework
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ && \
    docker-php-ext-install gd
RUN docker-php-ext-install intl \
                           pdo_mysql \
                           mbstring \
                           mcrypt \
                           zip
RUN pecl install apcu-beta && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini
