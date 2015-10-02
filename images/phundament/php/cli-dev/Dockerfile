# Docker image for Phundament 4 applications
# ------------------------------------------
#
# CLI tools (dev)
#

FROM phundament/php:5.6-cli-prod
MAINTAINER Tobias Munk <tobias@diemeisterei.de>
ENV IMAGE PHUNDAMENT_PHP_CLI_DEV

# Install system development packages
ENV TERM linux

# Install extra development packages
WORKDIR /root
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        libxml2-dev \
        nano \
        yui-compressor \
        linkchecker \
        nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm install -g less docco

# Install additional PHP-extensions
RUN docker-php-ext-configure bcmath && \
    docker-php-ext-install bcmath soap

RUN curl -o /root/compiler.tar.gz http://dl.google.com/closure-compiler/compiler-20150126.tar.gz && \
    tar -xzf /root/compiler.tar.gz && \
    rm /root/compiler.tar.gz

# Install packages required for Yii 2.0 Framework codeception testing globally
RUN composer global require  --prefer-dist \
        "codeception/codeception:2.0.*" "codeception/specify:*" "codeception/verify:*" && \
    composer global dumpautoload --optimize

# Install application template and core extensions to `phundament-src` directory for caching and installation by copying files.
ADD config.json /root/.composer/config.json
RUN rm -rf /phundament-src && \
    composer create-project --prefer-dist \
        phundament/app:4.0.0-rc7 \
        /phundament-src && \
    composer dumpautoload -d /phundament-src --optimize # 02.10.2015

# Setup application environment
WORKDIR /app

# Display , you can keep this container running with `tail -f /dev/null`
RUN echo "Informational message" && \
    echo "---------------------" && \
    echo "Phundament CLI and app-source container" && \
    echo "This container should exit with status 0 by default and can be used to run one-off commands."
CMD ["/bin/bash"]

