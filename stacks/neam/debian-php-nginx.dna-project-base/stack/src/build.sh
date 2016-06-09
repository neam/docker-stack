#!/bin/bash

# builds production source-code such as dist versions of webapps

# fail on any error
set -o errexit

# example
cd ui/webapps/yeoman-app-1
./full-build.sh
cd -

cd ui/webapps/yeoman-app-2
./full-build.sh
cd -

exit 0
