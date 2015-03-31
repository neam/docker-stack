# Dockerfile for PHP-CLI built for Yii 2.0 Framework Applications
# ===============================================================

FROM schmunk42/php:5.6-cli-yii-2.0.3-runtime
MAINTAINER Tobias Munk <tobias@diemeisterei.de>

# Fill composer cache with packages
ADD config.json /root/.composer/config.json
RUN composer create-project --prefer-dist \
        yiisoft/yii2-app-basic:2.0.3 \
        /app-src