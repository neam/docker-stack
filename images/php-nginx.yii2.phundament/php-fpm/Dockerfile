FROM schmunk42/php:5.6-fpm-yii-2.0.3-runtime

# Note: Source-code is used from phundament/app:cli or data volume
# Copy custom project config overrides

ADD conf.d-local/* /usr/local/etc/php/conf.d-local/

ADD run-phundament.sh /root/run-phundament.sh
CMD ["/root/run-phundament.sh"]