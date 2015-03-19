# Docker image for Phundament 4 applications
# ------------------------------------------
#
# CLI tools (prod)
#

FROM schmunk42/php:5.6-cli-yii-2.0.3-app-basic
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Install system development packages
ENV PHUNDAMENT_PHPCLI_APT_GET_DATE 2015-03-10-23-33
ENV TERM linux
RUN apt-get update && \
    apt-get install -y \
        mysql-client \
        openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install application template and core extension
# Phundament 4 and its extensions can be used directly from the image or serve as local cache
WORKDIR /app
ENV PHUNDAMENT_PHPCLI_CREATE_PROJECT 2015-03-10-23-33
ADD config.json /root/.composer/config.json
RUN rm -rf /app
RUN composer create-project --prefer-dist --no-dev \
        phundament/app:4.0.0-beta13 \
        /app && \
    composer dumpautoload --optimize

# Setup application environment
ENV APP_ENABLE_AUTOMIGRATIONS 1
RUN cp .env-dist .env

CMD ["/app/yii"]