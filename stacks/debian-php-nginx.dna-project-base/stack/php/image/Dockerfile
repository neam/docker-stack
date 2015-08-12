# Dockerfile for PHP-FPM 5.6.9 built for PHP/Nginx DNA Project Base docker-stack
# ===============================================================
#   docker build -t neam/dna-project-base-debian-php:5.6.9-fpm-0.2.2 .
#   docker push neam/dna-project-base-debian-php:5.6.9-fpm-0.2.2

FROM neam/debian-php:5.6.9-fpm

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below ENV date time to trigger docker to not used the cached apt system packages - general system packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-05-25 17:24"
RUN apt-get update && \
    apt-get upgrade -y -q

# Install PHP extensions available via apt-get
RUN apt-get install -y -q \
        php5-intl \
        php5-gd \
        php5-mysql \
        php5-sqlite \
        php5-mcrypt \
        php5-curl \
        php5-memcached \
        php5-redis \
        php5-mongo \
        php5-xsl \
        php5-apcu
