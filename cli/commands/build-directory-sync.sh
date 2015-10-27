#!/bin/bash

# Updates the clean cloned copy of the project repo in a build directory.

BRANCH=$(git symbolic-ref --short -q HEAD)
if [ "$BRANCH" == "" ]; then
    "A branch needs to be checked out in $(pwd)"
    exit 1
fi

DIR=$(basename $(pwd))
PROJECT_REPO_DIR=./
BUILD_DIR=../$DIR-build/
REV=$(git rev-parse --verify HEAD)

set -x

cd "$BUILD_DIR"
git fetch
git config advice.detachedHead false
git reset --hard "$REV"
git submodule foreach --recursive git reset --hard
git branch -f "$BRANCH"
git checkout "$BRANCH"
git submodule update --init --recursive

if [ ! -f .env ]; then
  cp .env.dist .env
fi
if [ ! -f deploy/config/secrets.php ]; then
  cp deploy/config/secrets.dist.php deploy/config/secrets.php
fi

exit 0
