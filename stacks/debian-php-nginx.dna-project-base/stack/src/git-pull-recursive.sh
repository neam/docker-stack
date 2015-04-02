#!/bin/bash

# fail on any error
set -o errexit

git pull
git submodule update --recursive
