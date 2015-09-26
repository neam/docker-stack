# Dockerfile for PHP-FPM 5.6.13 built for PHP/Nginx DNA Project Base docker-stack
# ===============================================================
#   docker build -t neam/dna-project-base-debian-php:5.6.13-fpm-0.4.0 .
#   docker push neam/dna-project-base-debian-php:5.6.13-fpm-0.4.0

FROM neam/debian-php:5.6.13-fpm

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below ENV date time to trigger docker to not used the cached apt system packages - general system packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-09-26 13:22"
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

# ====
# Install enough to be able to run administrative commands directly from within the php containers
# ====

# Enable editors and general tools for administration processes
ENV TERM xterm
RUN apt-get install -y -q \
        curl \
        wget \
        htop \
        less \
        jq \
        nano \
        sed \
        vim

# Version control systems
RUN apt-get install -y -q \
        git-flow \
        git-svn \
        mercurial \
        subversion

# Database clients
RUN apt-get install -y -q \
        mysql-client

# For erb templates
RUN apt-get install -y -q \
        ruby-full

# Add external apt repositories
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.5.0* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
