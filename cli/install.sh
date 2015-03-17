#!/bin/sh

set -x

BASEPATH="$DOCKER_STACK_SRC/stacks/$1/"
cp -r "$BASEPATH" .
cat "$DOCKER_STACK_SRC/stacks/$1/.docker-stack" | sed "s|{BASEPATH}|.|" > $APP_HOME/.docker-stack

exit 0