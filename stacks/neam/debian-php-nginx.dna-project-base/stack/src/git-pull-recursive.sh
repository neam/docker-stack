#!/bin/bash

# fail on any error
set -o errexit

git pull
git submodule init
git submodule update --recursive
