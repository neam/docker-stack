#!/bin/sh

if [ "$DOCKERSTACK_DEBUG" == "1" ]; then
    set -x;
fi

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

HTTP_PORT=$(docker-compose port $SERVICE_NAME $PORT | sed 's/[0-9.]*://');
if [ "HTTP_PORT" == "" ]; then
  echo "Could not find the corresponding HTTP_PORT"
  exit 1
fi
URL="http://$VIRTUAL_HOST:$HTTP_PORT";
URL=$URL"$URL_PATH";
echo $URL;
