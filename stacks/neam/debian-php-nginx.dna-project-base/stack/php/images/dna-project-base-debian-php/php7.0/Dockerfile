# Dockerfile for PHP (FPM 7.0.7, HHVM 3.13.1) built for Debian PHP/Nginx base docker-stack
# ===============================================================
#   docker build -t neam/dna-project-base-debian-php:0.7.0-php7 .
#   docker push neam/dna-project-base-debian-php:0.7.0-php7

FROM neam/debian-php:fpm-7.0.7-hhvm-3.13.1-for-debian-php-nginx-stack

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-06-07 07:33

# For erb templates
RUN apt-get install -y -q \
        ruby-full

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.5.0* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Install pipe viewer (pv) to monitor progress of commands that pipes large files
RUN apt-get install -y -q pv

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
