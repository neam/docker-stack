# Dockerfile for PHP-CLI built for Yii 2.0 Framework Applications
# ===============================================================

FROM schmunk42/php:5.6-cli
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system packages for PHP extensions required for Yii 2.0 Framework
RUN apt-get update \
    && apt-get -y install \
            g++ \
            git \
            libicu-dev \
            libmcrypt-dev \
            zlib1g-dev \
        --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# Install PHP extensions required for Yii 2.0 Framework
RUN docker-php-ext-install intl && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install zip && \
    pecl install apcu-beta && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

# Install composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require "fxp/composer-asset-plugin:1.0.0" && \
    composer global dumpautoload --optimize

# Install packages required for Yii 2.0 Framework codeception testing globally
RUN composer global require  --prefer-dist \
        "codeception/codeception:2.0.*" "codeception/specify:*" "codeception/verify:*" && \
    composer global dumpautoload --optimize