#!/bin/bash

# show commands
set -x

# fail on any error
set -o errexit

if [ "$PREFER" == "" ]; then
  PREFER=source
fi

# install local deps if available
# ...

exit 0
