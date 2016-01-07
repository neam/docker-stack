#!/bin/sh

SERVICE_NAME=$1
PORT=$2
VIRTUAL_HOST=$3
URL_PATH="${@:4}"

if [ "$SERVICE_NAME" == "" ]; then
  SERVICE_NAME=router
fi

if [ "$PORT" == "" ]; then
  PORT=80
fi

if [ "$VIRTUAL_HOST" == "" ] || [ "$VIRTUAL_HOST" == "-" ]; then
  VIRTUAL_HOST=$(echo $DOCKER_HOST | sed 's/tcp:\/\///' | sed 's/:[0-9.]*//');
fi

HTTP_PORT=$(docker-compose -f $STACK_YML port $SERVICE_NAME $PORT | sed 's/[0-9.]*://');
URL="http://$VIRTUAL_HOST:$HTTP_PORT";
URL=$URL"$URL_PATH";
echo $URL;
