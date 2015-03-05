# Base docker image for a DNA project source code image
# -----------------------------------------------------
# Available on docker hub as neam/dna-project-docker-base
# Build by running:
#     docker build -t 'neam/dna-project-docker-base' .

FROM debian:jessie

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Update to trigger new apt upgrade - system packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-03-05 09:56"
RUN apt-get update && \
    apt-get upgrade -y -q

# Enable editors and useful tools to include in base image
ENV TERM xterm
RUN apt-get install -y -q \
        curl \
        wget \
        htop \
        less \
        nano \
        sed \
        vim

# Show available versions and install version-sensitive packages
RUN echo "git-core \n $(apt-cache show git-core | grep -i version)" && \
    echo "php5-cli \n $(apt-cache show php5-cli | grep -i version)" && \
    apt-get install -y -q \
        git-core=1:2.1.4* \
        php5-cli=5.6.6*

# Add external apt repositories
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list

# Install Node.js (also runs apt-get update)
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
  echo "nodejs \n $(apt-cache show nodejs | grep -i version)" && \
  apt-get install -y nodejs=0.10.36*

# Install s3cmd
RUN echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && \
  apt-get install -y -q s3cmd=1.0.0*

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer && global asset plugin (a Yii 2.0 requirement)
ENV COMPOSER_HOME /root/.composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    /usr/local/bin/composer global require "fxp/composer-asset-plugin:1.0.*" && \
    /usr/local/bin/composer global dumpautoload --optimize
