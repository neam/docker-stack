# Dockerfile for PHP-CLI built for Yii 2.0 Framework Applications
# ===============================================================

FROM estebanmatias92/hhvm:3.5.1-cli
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

RUN apt-get update && \
    apt-get -y install \
            git \
            curl \
        --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

# Install composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require "fxp/composer-asset-plugin:1.0.0" && \
    composer global dumpautoload --optimize

# Fill composer cache with packages
ADD config.json /root/.composer/config.json
RUN composer create-project --prefer-dist \
        yiisoft/yii2-app-basic:2.0.3 \
        /app