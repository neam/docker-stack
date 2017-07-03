#!/bin/bash

# show commands
set -x

# fail on any error
set -o errexit

if [ "$PREFER" == "" ]; then
  PREFER=source
fi

composer install --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs

cd dna/
composer install --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs
cd -

cd external-apis/rest-api
composer install --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs
cd -

cd external-apis/rest-api-dna
composer install --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs
cd -

cd tools/code-generator
composer install --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs
cd -

exit 0
