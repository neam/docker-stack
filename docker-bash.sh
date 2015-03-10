#!/bin/bash

# For running scripts in the current directory via Docker
# Example usage: Cross-platform bash scripts
# Note: Requires a docker set-up that can mount local directories to the docker container

docker-compose run -it dosh "$@"

exit 0
