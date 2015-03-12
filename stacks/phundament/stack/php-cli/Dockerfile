# Docker image for Phundament 4 applications
# ------------------------------------------
#
# CLI tools
#

FROM schmunk42/php-yii2:cli
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system development packages
ENV IMAGE_CLI_APT_GET_DATE 2015-03-10-23-33
ENV TERM linux
RUN apt-get update && \
    apt-get install -y \
        mysql-client \
        yui-compressor \
        nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install extra development packages
WORKDIR /root
ENV IMAGE_CLI_CLOSURE_COMPILER 2015-03-10-23-33
RUN curl -o /root/compiler.tar.gz http://dl.google.com/closure-compiler/compiler-20150126.tar.gz && \
    tar -xzf /root/compiler.tar.gz && \
    rm /root/compiler.tar.gz

# Install application template and core extension
# Phundament 4 and its extensions can be used directly from the image or serve as local cache
WORKDIR /app
ENV IMAGE_CLI_CREATE_PROJECT 2015-03-10-23-33
ADD config.json /root/.composer/config.json
RUN /usr/local/bin/composer create-project --prefer-dist \
    phundament/app:4.0.0-beta13 \
    /app && \
    /usr/local/bin/composer dumpautoload --optimize

# Setup application environment
ENV APP_ENABLE_AUTOMIGRATIONS 1
RUN cp .env-dist .env

# Print informational message by default
CMD ["echo", "This is the CLI and data container of your Phundament 4 application, run or exec /bin/bash for multiple one-off commands.\n\nThis container will exit now, its data-volumes will stay available for other containers."]
