# Docker image for Phundament 4 applications
# ------------------------------------------
#
# CLI tools
#

FROM phundament/php:5.6-cli-4.0.0-prod
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system development packages
ENV PHUNDAMENT_PHP_BUILDER_APT_GET_DATE 2015-03-10-23-33
ENV TERM linux
RUN apt-get update && \
    apt-get install -y \
        nano \
        yui-compressor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install extra development packages
WORKDIR /root
ENV PHUNDAMENT_PHP_BUILDER_CLOSURE_COMPILER 2015-03-10-23-33
RUN curl -o /root/compiler.tar.gz http://dl.google.com/closure-compiler/compiler-20150126.tar.gz && \
    tar -xzf /root/compiler.tar.gz && \
    rm /root/compiler.tar.gz

# Install packages required for Yii 2.0 Framework codeception testing globally
RUN composer global require  --prefer-dist \
        "codeception/codeception:2.0.*" "codeception/specify:*" "codeception/verify:*" && \
    composer global dumpautoload --optimize

# Install application development packages
WORKDIR /app
ENV PHUNDAMENT_PHP_BUILDER_CREATE_PROJECT 2015-03-10-23-33
RUN /usr/local/bin/composer install --prefer-dist && \
    /usr/local/bin/composer dumpautoload --optimize

# Setup application environment
ENV APP_ENABLE_AUTOMIGRATIONS 1
RUN cp .env-dist .env

CMD ["/app/yii"]