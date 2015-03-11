# Dockerfile for PHP-FPM 5.6.6 built for PHP/Nginx/Memcache docker-stack
# ===============================================================
#   docker build -t neam/docker-stack-debian-php:5.6.6-fpm .
#   docker push neam/docker-stack-debian-php:5.6.6-fpm

FROM neam/debian-php:5.6.6-fpm

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below ENV date time to trigger docker to not used the cached apt system packages - general system packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-03-07 18:43"
RUN apt-get update && \
    apt-get upgrade -y -q

# Install PHP extensions available via apt-get
RUN apt-get install -y -q \
        php5-intl \
        php5-gd \
        php5-mysql \
        php5-mcrypt \
        php5-curl \
        php5-memcached \
        php5-redis \
        php5-mongo \
        php5-apcu

# Import official fpm config
ADD https://raw.githubusercontent.com/docker-library/php/1e07e9134490f53d24fbd23ee3521067c8ab2d29/5.6/fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf