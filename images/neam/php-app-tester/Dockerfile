# Base image - PHP app tester
# -----------------------------------------------------
# Example/base "catch-all" php app tester image to use to run tests
#
# Includes:
#
#  - npm package "api-mock"
#
# Available on docker hub as neam/php-app-tester
#
# Build by running:
#     docker build -t neam/php-app-tester .
#     docker push neam/php-app-tester
#
# Replace with your own project tag to build and push a custom base image for use in your project.

FROM neam/php-app-worker

# Update the below ENV date time to trigger docker to not used the cached apt system packages - general system packages will be based on apt state of this datetime
ENV APT_DOCKER_CACHE_TRIGGER "2015-03-19 10:50"
RUN apt-get update && \
    apt-get upgrade -y -q

# To be able to start a mock server based on an API blueprint
RUN apt-get install -y -q \
        build-essential
RUN npm install -g api-mock

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
