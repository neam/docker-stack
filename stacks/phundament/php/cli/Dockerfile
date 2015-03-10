# Docker container for Phundament 4 Applications
# ----------------------------------------------

FROM phundament/php:cli

# Add system development packages
ENV IMAGE_DEVELOPMENT_APT_GET_DATE 2015-01-04-01-00
RUN apt-get update && \
    apt-get install -y \
        yui-compressor \
        nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV TERM linux

ENV IMAGE_DEVELOPMENT_CLOSURE_COMPILER 2015-03-03-03-03
ADD compiler.jar /root/compiler.jar



WORKDIR /app

# Install application template and packages
# Phundament 4 and its extensions can be used directly from the image or serve as local cache
ENV YII_ENV prod
ENV YII_DEBUG 0
ENV IMAGE_PRODUCTION_CREATE_PROJECT 2015-03-03-23-29
ADD config.json /root/.composer/config.json
RUN /usr/local/bin/composer create-project --prefer-dist \
    phundament/app:4.0.0-beta13 \
    /app && \
    /usr/local/bin/composer dumpautoload --optimize

# Start application
ENV APP_ENABLE_AUTOMIGRATIONS 1
RUN cp .env-dist .env

# Install application development packages
##RUN /usr/local/bin/composer install --prefer-dist --optimize-autoloader

# Set development environment variables
ENV YII_ENV dev
ENV YII_DEBUG true

CMD /bin/bash