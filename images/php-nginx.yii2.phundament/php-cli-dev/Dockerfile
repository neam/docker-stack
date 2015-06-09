# Docker image for Phundament 4 applications
# ------------------------------------------
#
# CLI tools (dev)
#

FROM phundament/php:5.6-cli-prod
MAINTAINER Tobias Munk <tobias@diemeisterei.de>
ENV IMAGE PHUNDAMENT_PHP_CLI_DEV

# Install system development packages
ENV TRIGGER_APT_GET_INSTALL 2015-03-10-23-33
ENV TERM linux

# Install extra development packages
WORKDIR /root
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        nano \
        yui-compressor \
        linkchecker \
        nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm install -g less

ENV TRIGGER_CLOSURE_COMPILER 2015-03-10-23-33
RUN curl -o /root/compiler.tar.gz http://dl.google.com/closure-compiler/compiler-20150126.tar.gz && \
    tar -xzf /root/compiler.tar.gz && \
    rm /root/compiler.tar.gz

# Install packages required for Yii 2.0 Framework codeception testing globally
RUN composer global require  --prefer-dist \
        "codeception/codeception:2.0.*" "codeception/specify:*" "codeception/verify:*" && \
    composer global dumpautoload --optimize

# Install application template and core extensions to app-src directory for caching and installation
ENV TRIGGER_CREATE_PROJECT 2015-03-10-23-33
ADD config.json /root/.composer/config.json
RUN rm -rf /app-src && \
    composer create-project --prefer-dist \
        phundament/app:4.0.0-beta13 \
        /app-src && \
    composer dumpautoload -d /app-src --optimize

# Setup application environment
WORKDIR /app

# Display informational message, you can keep this container running with `tail -f /dev/null`
CMD ["echo", "Phundament CLI and app-source container"]

