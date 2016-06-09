#!/bin/bash

confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

# When running using docker-compose, the output from "read" will be hidden (bug?) so we echo the question instead
echo "This will remove all vendor directories in $(pwd) and two sub-directories below, do you want to continue? [y/N]"
confirm "" || exit 1

# show commands
set -x

# fail on any error
set -o errexit

rm -rf vendor/
rm -rf */vendor/
rm -rf */*/vendor/
PREFER=dist stack/src/install-deps.sh
