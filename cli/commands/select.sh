#!/bin/sh

if [ "$DOCKERSTACK_DEBUG" == "1" ]; then
    set -x;
fi

BASEPATH="$DOCKER_STACK_SRC/stacks/$1"
cat "$DOCKER_STACK_SRC/stacks/$1/.docker-stack" | sed "s|{BASEPATH}|$BASEPATH|" > $APP_HOME/.docker-stack

echo "Stack '$1' selected"

exit 0