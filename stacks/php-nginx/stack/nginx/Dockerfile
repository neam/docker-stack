# schmunk42/php
# -------------
# Basic nginx + php:fpm setup

FROM nginx:1.7

ADD conf.d/* /etc/nginx/conf.d/
ADD nginx.conf /etc/nginx/nginx.conf

ADD run.sh /root/run.sh

CMD ["/root/run.sh"]