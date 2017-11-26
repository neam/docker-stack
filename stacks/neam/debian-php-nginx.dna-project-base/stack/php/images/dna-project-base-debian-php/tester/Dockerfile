# Dockerfile for PHP (FPM 5.6.14, HHVM 3.11.0) built for PHP/Nginx DNA Project Base docker-stack
# ===============================================================
#   project-specific Dockerfile

FROM neam/dna-project-base-debian-php:0.8.0

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2017-11-01 15:46

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
