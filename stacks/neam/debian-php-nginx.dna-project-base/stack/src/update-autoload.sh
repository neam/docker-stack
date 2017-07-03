#!/bin/bash

# show commands
set -x

# fail on any error
set -o errexit

if [ "$PREFER" == "" ]; then
  PREFER=source
fi

composer dump-autoload

cd dna/
composer dump-autoload
cd -

cd external-apis/rest-api
composer dump-autoload
cd -

cd external-apis/rest-api-dna
composer dump-autoload
cd -

cd tools/code-generator
composer dump-autoload
cd -

exit 0
