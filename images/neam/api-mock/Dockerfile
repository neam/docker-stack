# Base image - PHP app tester
# -----------------------------------------------------
# Example/base "catch-all" php app tester image to use to run tests
#
# Includes:
#
#  - npm package "api-mock"
#
# Available on docker hub as neam/api-mock
#
# Build by running:
#     docker build -t neam/api-mock .
#     docker push neam/api-mock
#
# Replace with your own project tag to build and push a custom base image for use in your project.

FROM nodesource/jessie:0.10.45

RUN npm install -g api-mock
