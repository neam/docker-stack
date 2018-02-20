#!/bin/sh

if [ "$DOCKERSTACK_DEBUG" == "1" ]; then
    set -x;
fi

BASEPATH="$DOCKER_STACK_SRC/stacks/$1/"
cp -v -r "$BASEPATH" .
if [ -f "$DOCKER_STACK_SRC/stacks/$1/.docker-stack" ]; then
  cat "$DOCKER_STACK_SRC/stacks/$1/.docker-stack" | sed "s|{BASEPATH}|.|" > "$APP_HOME/.docker-stack"
fi

echo "Stack '$1' installed"

exit 0