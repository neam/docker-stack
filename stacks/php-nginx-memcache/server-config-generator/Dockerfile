FROM debian:jessie

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Update the below ENV date time to trigger docker to not used the cached apt system packages - packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-03-10 20:54"

# Install packages
RUN apt-get update && \
    apt-get upgrade -y -q && \
    apt-get install -y -q \
        # for json parsing on the cli
        jq \
        # for erb templates
        ruby-full \
        # editors and useful tools when inside container
        nano \
        sed \
        vim \
        curl \
        wget \
        htop \
        less

COPY . /generator
