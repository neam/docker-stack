# Dockerfile for PHP (FPM 7.0.20, HHVM 3.20.2) built for Debian PHP/Nginx base docker-stack
# ===============================================================
#   docker build -t neam/dna-project-base-debian-php:0.7.0-php7 .
#   docker push neam/dna-project-base-debian-php:0.7.0-php7

FROM neam/debian-php:fpm-7.0.20-hhvm-3.20.2-for-debian-php-nginx-stack

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Add jessie-backports (necessary for tmate installation)
RUN echo 'deb http://ftp.debian.org/debian jessie-backports main'> /etc/apt/sources.list.d/jessie-backports.list

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2017-07-03 16:26

# For erb templates
RUN apt-get install -y -q \
        ruby-full

# Install s3cmd
RUN apt-get install -y -q s3cmd=1.5.0* || (echo "s3cmd \n $(apt-cache show s3cmd | grep -i version)" && exit 1)

# Install pipe viewer (pv) to monitor progress of commands that pipes large files
RUN apt-get install -y -q pv

# Install tmate for on-demand ssh access directly into containers
RUN apt-get -t jessie-backports install -y -q tmate

# Install an up-to-date version of libmagic (5.31 instead of debian jessie stock 5.22)
RUN apt-get install -y -q \
	    automake \
	    gcc \
	    libtool \
	    make \
	    python \
	    zlib1g-dev
RUN cd /root/; curl -L -o ./libmagic.tar.gz https://github.com/file/file/archive/FILE5_31.tar.gz && \
    tar -xzf ./libmagic.tar.gz && \
    rm ./libmagic.tar.gz
RUN echo $(ls -l /root)/; cd /root/file-FILE5_31/; autoreconf -f -i && \
	./configure --disable-silent-rules --prefix=/usr && \
	make -j4 && \
	make -C tests check && \
	make install && \
	ldconfig && \
	make installcheck

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
