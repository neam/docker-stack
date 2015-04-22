# Docker image for Phundament 4 applications
# ------------------------------------------
#
# CLI tools (prod)
#

FROM schmunk42/php:5.6-cli-yii-2.0.3-runtime
MAINTAINER Tobias Munk <tobias@diemeisterei.de>
ENV IMAGE PHUNDAMENT_PHP_CLI_PROD

# Install system development packages
ENV TRIGGER_APT_GET_DATE 2015-03-10-23-33
ENV TERM linux
RUN apt-get update && \
    apt-get install -y \
        mysql-client \
        openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app
