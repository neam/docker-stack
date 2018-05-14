# Dockerfile for PHP (FPM 7.2.5, HHVM 3.x.y) built for PHP/Nginx DNA Project Base docker-stack
# ===============================================================
#   docker build -t neam/dna-project-base-debian-php:1.0.0-php7 .
#   docker push neam/dna-project-base-debian-php:1.0.0-php7

FROM neam/debian-php:fpm-7.2.5-hhvm-3.x.y-for-debian-php-nginx-stack

MAINTAINER Fredrik Wollsén <fredrik@neam.se>

# Add stretch backports (to be able to get some more updated versions of software packages)
RUN echo 'deb http://http.debian.net/debian stretch-backports main contrib non-free' > /etc/apt/sources.list.d/stretch-backports.list

# Apt source for: Database clients
RUN wget https://dev.mysql.com/get/mysql-apt-config_0.8.6-1_all.deb && \
        dpkg -i mysql-apt-config_0.8.6-1_all.deb && \
        rm mysql-apt-config_0.8.6-1_all.deb

# Apt source for: Google Cloud SDK
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
        echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2018-05-09 19:40

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
  apt-get install -y nodejs=8.11.*

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

# Install exiftool
#RUN apt-get install -t stretch-backports -y -q \
#        libimage-exiftool-perl=10.79.0* || (echo "exiftool \n $(apt-cache show libimage-exiftool-perl | grep -i version)" && exit 1)
RUN wget https://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.79.tar.gz && \
            tar -xvf Image-ExifTool-10.79.tar.gz && \
            cd Image-ExifTool-10.79 && ls -l && \
            perl Makefile.PL && \
            make test && \
            make install && \
            cd - && \
            rm Image-ExifTool-10.79.tar.gz

# Version control systems
RUN apt-get install -y -q \
        git-flow \
        git-svn \
        mercurial \
        subversion

# Database clients
RUN apt-get install -y -q \
        mysql-client

# Google Cloud SDK
RUN apt-get install -y -q \
        google-cloud-sdk && \
        gcloud config set pass_credentials_to_gsutil false

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
