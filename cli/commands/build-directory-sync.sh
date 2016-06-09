#!/bin/bash

if [ "$DOCKERSTACK_DEBUG" == "1" ]; then
    set -x;
fi

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

if [ ! -d "$BUILD_DIR" ]; then
  echo "No build dir \"$BUILD_DIR\" exists. Did you run docker-stack build-directory-init yet?"
  exit 1
fi

set -x

cd "$BUILD_DIR"
git fetch
git config advice.detachedHead false
git reset --hard "$REV"
git submodule foreach --recursive git reset --hard
git branch -f "$BRANCH"
git checkout "$BRANCH"
git submodule update --init --recursive

set +x

if [ ! -f .env ]; then
  cp .env.dist .env
fi
if [ ! -f .current-local-cli-data-profile ]; then
  cp .current-local-cli-data-profile.dist .current-local-cli-data-profile
fi
if [ ! -f deploy/config/deploy-prepare-secrets.php ]; then
  cp deploy/config/deploy-prepare-secrets.dist.php deploy/config/deploy-prepare-secrets.php
fi
if [ ! -f deploy/config/secrets.php ]; then
  cp deploy/config/secrets.dist.php deploy/config/secrets.php
fi

exit 0
