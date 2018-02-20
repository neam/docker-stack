#!/bin/bash

# show commands
set -x

# fail on any error
set -o errexit

# make sure that the shorthand "composer" is available and refers to using our shipped composer.phar (for the sake of consistency)
script_path=`dirname $0`
cd $script_path/../..
export project_abspath=$(pwd)
function composer() {
    php $project_abspath/composer.phar $@
}
export -f composer

if [ "$PREFER" == "" ]; then
  PREFER=source
fi

composer -vv update --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs

cd dna/
composer -vv update --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs
cd -

cd external-apis/rest-api
composer -vv update --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs
cd -

cd tools/code-generator
composer -vv update --prefer-$PREFER --optimize-autoloader --ignore-platform-reqs
cd -

exit 0
