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

FROM neam/php-app-worker:0.6.0

# Update the below commented date time to match the time docker fetched the system package information - an update will trigger docker to fetch the information anew
RUN apt-get update && \
    apt-get upgrade -y -q # 2016-02-26 10:52

# To be able to start a mock server based on an API blueprint
RUN apt-get install -y -q \
        build-essential
RUN npm install -g api-mock

# Clean apt caches
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
