#!/bin/bash

# Uncomment to debug
set -x

DIR="$1"

envs=$(printenv)
tmp=$(mktemp -d)

for file in "$DIR/"*
do

    echo $file
    mv $file $tmp/tpl
    perl -p -e 's/\$\{(\w+)\}/(exists $ENV{$1}?$ENV{$1}:"MISSING_ENV_VAR_$1")/eg' < $tmp/tpl > $file

done

exit 0