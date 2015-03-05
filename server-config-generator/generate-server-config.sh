#!/bin/bash

set -e
set -o pipefail
shopt -s dotglob

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
source /app/.serialized_composer_json_data.sh

echo $PHP_VERSION
echo $NGINX_VERSION
echo $FRAMEWORK

# generate nginx config

if [ ! -n "$PHPFPM_PORT_9000_TCP_ADDR" ] ; then
protip "The env var PHPFPM_PORT_9000_TCP_ADDR is missing, so the generated configuration will not work"
fi

if [ ! -n "$PHPFPM_PORT_9000_TCP_PORT" ] ; then
protip "The env var PHPFPM_PORT_9000_TCP_PORT is missing, so the generated configuration will not work"
fi

erb "$GENERATOR_DIR/templates/nginx/00-defaults.conf.erb" > "$BUILD_DIR/server-config/nginx/conf.d/00-defaults.conf"

# note about framework config inclusion
if [ -n "$FRAMEWORK" ] ; then
protip "You composer.json specifies framework $(package_framework), thus we will attempt to include Nginx configuration for that framework."
fi

erb "$GENERATOR_DIR/templates/nginx/project.conf.erb" > "$BUILD_DIR/server-config/nginx/conf.d/project.conf"

# generate php-fpm config

for var in $(env | cut -f1 -d=); do
  echo "env[$var] = \$${var}" >> $BUILD_DIR/server-config/php/conf.d/env.ini
done

if [ -n "\$NEW_RELIC_LICENSE_KEY" ]; then
  erb "$GENERATOR_DIR/templates/php/newrelic.ini.erb" > "$BUILD_DIR/server-config/php/conf.d/newrelic.ini"
  echo "newrelic.license=\"\$NEW_RELIC_LICENSE_KEY\"" > $BUILD_DIR/server-config/php/conf.d/newrelic_license.ini
fi

rm "$BUILD_DIR/server-config/php/conf.d/project.ini"
for conf in $PHP_EXTRA_CONFIG; do
  echo "$conf" >> "$BUILD_DIR/server-config/php/conf.d/project.ini"
done

for include in $PHP_INCLUDES; do
  cp "$BUILD_DIR/$include" "/app/vendor/php/etc/conf.d/"
done
