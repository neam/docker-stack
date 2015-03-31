# Docker image for Phundament 4 applications
# ------------------------------------------
#
# CLI tools (dev)
#

FROM phundament/php:5.6-cli-4.0.0-prod
MAINTAINER Tobias Munk <tobias@diemeisterei.de>
ENV IMAGE PHUNDAMENT_PHP_CLI_DEV

# Install system development packages
ENV TRIGGER_APT_GET_INSTALL 2015-03-10-23-33
ENV TERM linux
RUN apt-get update && \
    apt-get install -y \
        nano \
        yui-compressor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install extra development packages
WORKDIR /root
ENV TRIGGER_CLOSURE_COMPILER 2015-03-10-23-33
RUN curl -o /root/compiler.tar.gz http://dl.google.com/closure-compiler/compiler-20150126.tar.gz && \
    tar -xzf /root/compiler.tar.gz && \
    rm /root/compiler.tar.gz

# Install lessc for asset conversion
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get install --no-install-recommends -y \
        nodejs && \
    rm -r /var/lib/apt/lists/* && \
    npm install -g less

# Install linkchecker
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        linkchecker && \
    rm -r /var/lib/apt/lists/*

# Install packages required for Yii 2.0 Framework codeception testing globally
RUN composer global require  --prefer-dist \
        "codeception/codeception:2.0.*" "codeception/specify:*" "codeception/verify:*" && \
    composer global dumpautoload --optimize


# Install application template and core extension
# Phundament 4 and its extensions can be used directly from the image or serve as local cache
ENV TRIGGER_CREATE_PROJECT 2015-03-10-23-33
ADD config.json /root/.composer/config.json
RUN rm -rf /app-src
RUN composer create-project --prefer-dist \
        phundament/app:4.0.0-beta13 \
        /app-src && \
    composer dumpautoload -d /app-src --optimize

# Setup application environment
WORKDIR /app
ENV APP_ENABLE_AUTOMIGRATIONS 1


CMD ["/app/yii"]