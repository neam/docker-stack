#!/bin/bash

DIR="$1"

envs=$(printenv)

for file in "$DIR/*"
do

    for env in $envs
    do
        IFS== read name value <<< "$env"
        sed -i "s|\${${name}}|${value}|g" $file
    done

done

exit 0