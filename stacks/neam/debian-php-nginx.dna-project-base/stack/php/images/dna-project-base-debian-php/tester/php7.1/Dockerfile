# Dockerfile for PHP (FPM 5.6.14, HHVM 3.11.0) built for PHP/Nginx DNA Project Base docker-stack
# ===============================================================
#   project-specific Dockerfile

FROM neam/dna-project-base-debian-php:0.8.0-php7.1

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2017-07-04 09:03

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
        lsb-release gnupg \
        sed \
        telnet \
        net-tools \
        vim

# Install Node.js and npm for installation of dependencies during build (Note: runs apt-get update)
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
  echo "nodejs \n $(apt-cache show nodejs | grep -i version)" && \
  apt-get install -y nodejs=4.8.*

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
