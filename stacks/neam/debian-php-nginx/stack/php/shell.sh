#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Show what the script is doing
set -x

# Copy custom project config overrides
/app/stack/php/inject-config.sh

# Manage permissions
/app/stack/php/manage-permissions.sh

# Start a shell
bash
