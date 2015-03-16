#!/bin/sh

export DOCKER_HOST_IP=$(echo $DOCKER_HOST | sed 's/tcp:\/\///' | sed 's/:[0-9.]*//');
export WEB_PORT_80=$(docker-compose -f $STACK_HOME/local.yml port web 80 | sed 's/[0-9.]*://');
export URL="http://$DOCKER_HOST_IP:$WEB_PORT_80";
URL=$URL"$@";
echo $URL;
