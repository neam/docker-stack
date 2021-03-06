#!/bin/sh

if [ "$DOCKERSTACK_DEBUG" == "1" ]; then
    set -x;
fi

DRIVER=$1
SERVICE_NAME=$2
PORT=$3
URL_PATH="${@:4}"

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
export DB_PORT=$(docker-compose port $SERVICE_NAME $PORT | sed 's/[0-9.]*://');
if [ "DB_PORT" == "" ]; then
  echo "Could not find the corresponding DB_PORT"
  exit 1
fi
export URL="$DRIVER://$DOCKER_HOST_IP:$DB_PORT";
URL=$URL"$URL_PATH";
echo $URL;
