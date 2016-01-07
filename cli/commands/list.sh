#!/bin/sh

PUBLISHERS=$(ls "$DOCKER_STACK_SRC/stacks/")
for PUBLISHER in $PUBLISHERS; do
  STACKS=$(ls "$DOCKER_STACK_SRC/stacks/$PUBLISHER/")
  for STACK in $STACKS; do
    echo $PUBLISHER/$STACK
  done
done

exit 0
