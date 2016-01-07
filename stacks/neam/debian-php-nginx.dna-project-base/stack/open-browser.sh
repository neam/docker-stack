#!/usr/bin/env bash

if [ "$DATA" == "" ] || [ "$DATA" == "%DATA%" ]; then
  echo "Using DATA=clean-db since no DATA env var was set. To set:"
  echo "  export DATA=example"
  echo "Then run this script again"
  DATA=clean-db
fi

URL="$(docker-stack local url router 80 $DATA._PROJECT_.192.168.99.100.xip.io "$1")"

echo "Opening URL:"
echo $URL

open $URL

exit 0
