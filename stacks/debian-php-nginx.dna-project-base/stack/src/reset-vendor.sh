#!/bin/bash

# fail on any error
set -o errexit

rm -rf vendor/
rm -rf */vendor/
rm -rf */*/vendor/
PREFER=dist stack/src/install-deps.sh
