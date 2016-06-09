#!/bin/bash

if [ "$DOCKERSTACK_DEBUG" == "1" ]; then
    set -x;
fi

# Creates a clean cloned copy of the project repo in a build directory.
#
# By building the project docker image(s) in the clean cloned copy, the build
# context will not include temporary files with possibly (inadvertadly)
# sensitive information lying around will not be included in the image
# More importantly, it prevents anything but committed changes to be
# included in the docker image(s)

DIR=$(basename $(pwd))
PROJECT_REPO_DIR=./
BUILD_DIR=../$DIR-build/
REV=$(git rev-parse --verify HEAD)

set -x

rm -rf "$BUILD_DIR"

git clone "$PROJECT_REPO_DIR" "$BUILD_DIR"
cd "$BUILD_DIR"
git config advice.detachedHead false
git checkout "$REV"
git submodule update --init --recursive

exit 0
