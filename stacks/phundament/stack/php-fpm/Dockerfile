FROM schmunk42/php-yii2:fpm

# Note: Source-code is used from phundament/app:cli volume
# Copy custom project config overrides

ADD conf.d/* /usr/local/etc/php/conf.d/
ADD pool.d/* /usr/local/etc/php/pool.d/
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

ADD run.sh /root/run.sh

CMD ["/root/run.sh"]