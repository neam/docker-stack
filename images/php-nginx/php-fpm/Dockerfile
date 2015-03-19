# schmunk42/php
# -------------
# Basic nginx + php:fpm setup
# Note: PHP application source-code can be used in an image `FROM php:5.6-cli` or data volume.

FROM php:5.6-fpm

# Add PHP-FPM + nginx configuration
ADD pool.d/* /usr/local/etc/php/pool.d/
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

# Run FPM
ADD run.sh /root/run.sh
CMD ["/root/run.sh"]
EXPOSE 9000