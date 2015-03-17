#!/bin/sh

set -x

BASEPATH="$DOCKER_STACK_SRC/stacks/$1"
cat "$DOCKER_STACK_SRC/stacks/$1/.docker-stack" | sed "s|{BASEPATH}|$BASEPATH|" > $APP_HOME/.docker-stack

exit 0