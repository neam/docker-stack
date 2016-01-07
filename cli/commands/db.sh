#!/bin/sh

DRIVER=$1
SERVICE_NAME=$2
PORT=$3

if [ "$DRIVER" == "" ]; then
  DRIVER=mysql
fi

if [ "$SERVICE_NAME" == "" ]; then
  SERVICE_NAME=localdb
fi

if [ "$PORT" == "" ]; then
  PORT=3306
fi

export DOCKER_HOST_IP=$(echo $DOCKER_HOST | sed 's/tcp:\/\///' | sed 's/:[0-9.]*//');
export WEB_PORT_80=$(docker-compose -f $STACK_YML port $SERVICE_NAME $PORT | sed 's/[0-9.]*://');
export URL="$DRIVER://$DOCKER_HOST_IP:$WEB_PORT_80";
URL=$URL"$@";
echo $URL;
