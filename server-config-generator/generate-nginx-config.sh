#!/bin/bash

set -e
set -o pipefail
shopt -s dotglob

if [ "$APP_DIR" == "" ]; then
    echo "APP_DIR must be set. (to a directory where '.serialized_composer_json_data.sh' resides)"
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
source "$APP_DIR/.serialized_composer_json_data.sh"

echo $NGINX_VERSION
echo $FRAMEWORK
env

# generate nginx config

status "Generating project.conf (project-specific nginx settings)"

# note about framework config inclusion
if [ -n "$FRAMEWORK" ] ; then
    if [ ! -n "$GENERATOR_DIR/templates/$FRAMEWORK.conf.erb" ]; then
        status "You composer.json-specified framework '$FRAMEWORK' has no matching configuration template. Default configuration will be used"
        FRAMEWORK=default_SITE
    fi
fi

erb "$GENERATOR_DIR/templates/nginx/project.conf.erb" > "$APP_DIR/server-config/nginx/conf.d/project.conf"

status "Done!"
