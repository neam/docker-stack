#!/usr/bin/env bash

git submodule update --init  
ls -la  
  
set -e
set -v
  
export DOCKER_CLIENT_TIMEOUT=120  

make -f Makefile-schmunk42 build  
make -f Makefile-schmunk42 test  
  

  
exit 0