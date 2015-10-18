#!/bin/bash

set -e
set -o pipefail
shopt -s dotglob

APP_DIR=/app
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
source "$APP_DIR/stack/.serialized_composer_json_data.sh"

export PHP_VERSION
export NGINX_VERSION
export DOCUMENT_ROOT
export INDEX_DOCUMENT
export FRAMEWORK
export PHP_EXTRA_CONFIG
export PHP_INCLUDES
export PHP_SERVICE
export PHP_RUNTIME
export COMPILE_CMD
export NGINX_INCLUDES
export NGINX_LOCATIONS
export USER_LOG_FILES
export DOCUMENT_ROOT
export NEWRELIC_ENABLED

# generate nginx config

status "Generating app.conf (app-specific nginx settings)"

# note about framework config inclusion
if [ "$FRAMEWORK" != "" ] ; then
    if [ ! -f "$GENERATOR_DIR/templates/nginx/frameworks/$FRAMEWORK.conf.erb" ]; then
        status "Warning: You composer.json-specified framework '$FRAMEWORK' has no matching configuration template. Default configuration will be used"
        FRAMEWORK=default_SITE
    fi
fi

cd $GENERATOR_DIR
erb "templates/nginx/app.conf.erb" > "$APP_DIR/stack/nginx/conf.d/app.conf"

status "Done!"
