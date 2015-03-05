#!/bin/bash

# For running scripts in the current directory via Docker
# Example usage: Cross-platform bash scripts

docker run -a stdin -a stdout -i -t -v .:/pwd debian:jessie /bin/bash -c "cd /pwd && $@"

exit 0