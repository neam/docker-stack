#!/usr/bin/env bash

if [ "$DATA" == "" ]; then
  echo "Using DATA=clean-db since no DATA env var was set. To set:"
  echo "  export DATA=example"
  echo "Then run this script again"
  DATA=clean-db
fi

open $(docker-stack local url router 80 $DATA._PROJECT_.local "$1")

exit 0
