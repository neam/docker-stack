# Dockerfile for PHP (FPM 7.1.13, HHVM 3.x.y) built for Debian PHP/Nginx base docker-stack
# ===============================================================
#   docker build -t neam/dna-project-base-debian-php:1.0.0-php7 .
#   docker push neam/dna-project-base-debian-php:1.0.0-php7

FROM neam/debian-php:fpm-7.1.13-hhvm-3.x.y-for-debian-php-nginx-stack

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2018-01-19 14:02

# Enable editors and general tools for administration processes
ENV TERM xterm
RUN apt-get install -y -q \
        curl \
        wget \
        gnupg \
        htop \
        less \
        jq \
        nano \
        man-db \
        lsb-release \
        sed \
        telnet \
        net-tools \
        vim

# Install Node.js (incl. npm for installation of dependencies during build) (Note: runs apt-get update)
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  echo "nodejs \n $(apt-cache show nodejs | grep -i version)" && \
  apt-get install -y nodejs=8.9.*

# For erb templates
RUN apt-get install -y -q \
        ruby-full

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.6.1* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Install pipe viewer (pv) to monitor progress of commands that pipes large files
RUN apt-get install -y -q pv

# Install tmate for on-demand ssh access directly into containers
RUN apt-get install -y -q tmate

# Build essential is necessary to compile some binary dependencies (incl npm dependencies)
RUN apt-get install build-essential -y -q

# Version control systems
RUN apt-get install -y -q \
        git-flow \
        git-svn \
        mercurial \
        subversion

# Database clients
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.6-1_all.deb && \
        dpkg -i mysql-apt-config_0.8.6-1_all.deb && \
        rm mysql-apt-config_0.8.6-1_all.deb && \
        apt-get update && \
        apt-get install -y -q \
        mysql-client

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
