#!/bin/bash

echo "Running $WORKER_CMD"

set -x
$WORKER_CMD

exit 0
