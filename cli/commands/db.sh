#!/bin/sh

export DOCKER_HOST_IP=$(echo $DOCKER_HOST | sed 's/tcp:\/\///' | sed 's/:[0-9.]*//');
export WEB_PORT_80=$(docker-compose -f $STACK_YML port localdb 3306 | sed 's/[0-9.]*://');
export URL="mysql://$DOCKER_HOST_IP:$WEB_PORT_80";
URL=$URL"$@";
echo $URL;
