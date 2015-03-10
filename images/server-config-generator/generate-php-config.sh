#!/bin/bash

set -e
set -o pipefail
shopt -s dotglob

if [ "$APP_DIR" == "" ]; then
    echo "APP_DIR must be set. (to a directory where 'server-config/.serialized_composer_json_data.sh' resides)"
    exit;
fi

GENERATOR_DIR="$(dirname $0)"

error() {
  echo " !     $*" >&2
  exit 1
}

status() {
  echo "-----> $*"
}

protip() {
  echo
  echo "TIP: $*" | indent
  echo
}

# sed -l basically makes sed replace and buffer through stdin to stdout
# so you get updates while the command runs and dont wait for the end
# e.g. npm install | indent
indent() {
  c='s/^/       /'
  case $(uname) in
    Darwin) sed -l "$c";; # mac/bsd sed: -l buffers on line boundaries
    *)      sed -u "$c";; # unix/gnu sed: -u unbuffered (arbitrary) chunks of data
  esac
}

# Show script name and line number when errors occur to make buildpack errors easier to debug
trap 'error "Script error in $0 on or near line ${LINENO}"' ERR

# Read the serialized composer.json data
source "$APP_DIR/server-config/.serialized_composer_json_data.sh"

# generate php-fpm config

status "Generating project.ini (project-required php settings)"
echo "" > "$APP_DIR/server-config/php/conf.d/project.ini"
for conf in $PHP_EXTRA_CONFIG; do
  echo "$conf" >> "$APP_DIR/server-config/php/conf.d/project.ini"
done

status "Copying newrelic.ini (if new relic is enabled in composer.json)"
if [ "$NEWRELIC_ENABLED" == "true" ]; then
  cp "$GENERATOR_DIR/templates/php/newrelic.ini" > "$APP_DIR/server-config/php/conf.d/newrelic.ini"
fi

status "Including additional project-required includes (if any)"
for include in $PHP_INCLUDES; do
  cp "$APP_DIR/$include" "/app/vendor/php/etc/conf.d/"
done

status "Done!"
