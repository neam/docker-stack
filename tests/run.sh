#!/usr/bin/env bash

git submodule update --init  
ls -la  
  
set -e  
  
export DOCKER_CLIENT_TIMEOUT=120  

sed -i "s|0000000000000000000000000000000000000000|${GITHUB_TOKEN}|" images/phundament/php/cli-dev/config.json
touch -acmt 1010101010 images/phundament/php/cli-dev/config.json  
  
make -f Makefile-schmunk42 build  
make -f Makefile-schmunk42 test  
  

  
exit 0