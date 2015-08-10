#!/usr/bin/env bash

git submodule update --init  
ls -la  
  
set -e  
  
export DOCKER_CLIENT_TIMEOUT=120  

sed -i "s|0000000000000000000000000000000000000000|${GITHUB_TOKEN}|" images/phundament/php/cli-dev/config.json
touch -acmt 1010101010 images/phundament/php/cli-dev/config.json  
  
make -f Makefile-schmunk42 build  
make -f Makefile-schmunk42 test  
  
echo "WARNING, DUPLICATE IMAGE TAGS ARE NOT PUSHED AND DON\'T THROW A BUILD ERROR"  
set +e  
make -f Makefile-schmunk42 tag  
  
docker login --username="${DOCKERHUB_USER}" --password="${DOCKERHUB_PASS}" --email="noreply@example.com" https://index.docker.io/v1/
make -f Makefile-schmunk42 push  
  
exit 0