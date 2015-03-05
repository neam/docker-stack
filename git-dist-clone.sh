#!/bin/bash

# Creates a clean cloned copy of the project repo in a dist subdirectory
# By building the project docker image in the clean cloned copy, the build context
# will not include temporary files lying around, and more importantly: Configuration
# files with sensitive information will not inadvertadly be included in the image

PROJECT_REPO_DIR=./
TMP_WORK_DIR=dist/
REV=$(git rev-parse --verify HEAD)

set -x

rm -rf "$TMP_WORK_DIR"

git clone "$PROJECT_REPO_DIR" "$TMP_WORK_DIR"
cd "$TMP_WORK_DIR"
git config advice.detachedHead false
git checkout "$REV"
git submodule update --init --recursive
