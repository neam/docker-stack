# Docker image for Phundament 4 applications
# ------------------------------------------
#
# FPM
#

FROM schmunk42/php:5.6-fpm-yii-2.0-runtime
ENV IMAGE PHUNDAMENT_PHP_FPM_PROD

# Note: Source-code is used from phundament/php:cli

# Install FTP extension for accessing remote file-systems
RUN apt-get update && \
    apt-get -y install \
        libssl-dev \
        --no-install-recommends && \
    apt-get clean && \
    docker-php-ext-install ftp && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* # 14.09.2015

# PHP configuration
ADD conf.d/* /usr/local/etc/php/conf.d/

# Prepare folders for Yii 2.0 Framework (www-data)
RUN mkdir -p /app/runtime /app/web/assets && \
    chown -R 1000:33 /app/runtime /app/web/assets

# Startup script
ADD run-phundament.sh /root/run-phundament.sh
CMD ["/root/run-phundament.sh"]