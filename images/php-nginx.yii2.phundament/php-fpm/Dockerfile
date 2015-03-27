# Docker image for Phundament 4 applications
# ------------------------------------------
#
# FPM
#

FROM schmunk42/php:5.6-fpm-yii-2.0.3-runtime
ENV IMAGE PHUNDAMENT_PHP_FPM

# Note: Source-code is used from phundament/php:cli

# PHP configuration
ADD conf.d-local/* /usr/local/etc/php/conf.d-local/

# Prepare folders for Yii 2.0 Framework (www-data)
RUN mkdir -p /app/runtime /app/web/assets && \
    chown -R 1000:33 /app/runtime /app/web/assets

# Startup script
ADD run-phundament.sh /root/run-phundament.sh
CMD ["/root/run-phundament.sh"]