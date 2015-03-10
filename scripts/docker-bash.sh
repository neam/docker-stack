#!/bin/bash

# For running scripts in the current directory via Docker
# Example usage: Cross-platform bash scripts
# Note: Requires a docker set-up that can mount local directories to the docker container

docker run -a stdin -a stdout -i -t -v "$(pwd):/pwd" -w="/pwd" debian:jessie "$@"

exit 0
