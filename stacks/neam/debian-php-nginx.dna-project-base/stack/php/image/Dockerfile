# Dockerfile for PHP (FPM 5.6.14, HHVM 3.11.0) built for PHP/Nginx DNA Project Base docker-stack
# ===============================================================
#   docker build -t neam/dna-project-base-debian-php:0.6.0 .
#   docker push neam/dna-project-base-debian-php:0.6.0

FROM neam/debian-php:fpm-5.6.14-hhvm-3.11.0-for-debian-php-nginx-stack

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-01-07 13:16

# For erb templates
RUN apt-get install -y -q \
        ruby-full

# Add external apt repositories
#RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
#RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.5.0* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
