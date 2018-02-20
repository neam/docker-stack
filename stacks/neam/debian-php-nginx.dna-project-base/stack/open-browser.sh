#!/usr/bin/env bash

if [ "$DATA" == "" ] || [ "$DATA" == "%DATA%" ]; then
  echo "Using DATA=clean-db since no DATA env var was set. To set:"
  echo "  export DATA=example"
  echo "Then run this script again"
  DATA=clean-db
fi

URL="$(stack/url.sh router 80 $DATA._PROJECT_.127.0.0.1.xip.io "$1")"

echo "Opening URL:"
echo $URL

case $OSTYPE in
  darwin*)
    open $URL ;;
  linux-gnu)
    xdg-open $URL ;;
  *)

esac

exit 0
