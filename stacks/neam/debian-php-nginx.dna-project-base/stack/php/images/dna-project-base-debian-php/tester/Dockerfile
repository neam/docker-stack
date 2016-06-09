# Dockerfile for PHP (FPM 5.6.14, HHVM 3.11.0) built for PHP/Nginx DNA Project Base docker-stack
# ===============================================================
#   project-specific Dockerfile

FROM neam/dna-project-base-debian-php:0.6.2

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-06-07 07:33

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
        telnet \
        net-tools \
        vim

# Install Node.js and npm for installation of dependencies during build (Note: runs apt-get update)
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
  echo "nodejs \n $(apt-cache show nodejs | grep -i version)" && \
  apt-get install -y nodejs=4.4.*

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
