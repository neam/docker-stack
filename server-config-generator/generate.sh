#!/bin/bash

set -e
set -o pipefail
shopt -s dotglob

if [ "$BUILD_DIR" == "" ]; then
    echo "BUILD_DIR must be set to a directory where a copy of the project composer.json resides"
    exit;
fi

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

function has_heroku_extra() {
   jq --raw-output '.extra.heroku // ""' < "$BUILD_DIR/composer.json"
}

function package_document_root() {
    jq --raw-output ".extra.${composer_extra_key}[\"document-root\"] // \"\"" < "$BUILD_DIR/composer.json"
}

function package_index_file() {
    jq --raw-output ".extra.${composer_extra_key}[\"index-document\"] // \"index.php\"" < "$BUILD_DIR/composer.json"
}

function package_framework() {
    jq --raw-output ".extra.${composer_extra_key}.framework // \"\"" < "$BUILD_DIR/composer.json"
}

function package_nginx_version() {
    jq --raw-output ".extra.${composer_extra_key}.engines.nginx // \"default\"" < "$BUILD_DIR/composer.json"
}

function package_php_version() {
    jq --raw-output ".extra.${composer_extra_key}.engines.php // \"default\"" < "$BUILD_DIR/composer.json"
}

function package_php_config() {
    jq --raw-output ".extra.${composer_extra_key}[\"php-config\"] // [] | .[]" < "$BUILD_DIR/composer.json"
}

function package_php_includes() {
    jq --raw-output ".extra.${composer_extra_key}[\"php-includes\"] // [] | .[]" < "$BUILD_DIR/composer.json"
}

function package_nginx_includes() {
    jq --raw-output ".extra.${composer_extra_key}[\"nginx-includes\"] // [] | .[]" < "$BUILD_DIR/composer.json"
}

function package_nginx_locations() {
    jq --raw-output '.extra.${composer_extra_key}[\"nginx-locations\"] // []' < "$BUILD_DIR/composer.json"
}

function package_log_files() {
    jq --raw-output ".extra.${composer_extra_key}[\"log-files\"] // [] | .[]" < "$BUILD_DIR/composer.json"
}

function package_compile_cmd() {
    jq --raw-output ".extra.${composer_extra_key}[\"compile\"] // [] | .[]" < "$BUILD_DIR/composer.json"
}

function package_newrelic_enabled() {
    local val=$(jq --raw-output ".extra.${composer_extra_key}[\"newrelic\"] // false" < "$BUILD_DIR/composer.json")

    if [ "$val" = "true" ]; then
        return 0
    else
        return 1
    fi
}

# Read config variables from composer.json if it exists
if [ -f "$BUILD_DIR/composer.json" ]; then
  composer_extra_key="server-config"
  if [ -n "$(has_heroku_extra)" ] ; then
    protip "Your composer.json is using the key 'extra' → 'heroku', you should switch to 'extra' → 'server-config' if this project does not work on heroku"
    composer_extra_key="heroku"
  fi

  # note about debian jessie
  if [ -n "$(package_php_version)" ] ; then
    protip "Foo"
  fi

  if [ -n "$(package_nginx_version)" ] ; then
    protip "Foo"
  fi

  if [ -n "$(package_framework)" ] ; then
    protip "Foo"
  fi

  PHP_VERSION=$(package_php_version)
  NGINX_VERSION=$(package_nginx_version)
  DOCUMENT_ROOT=$(package_document_root)
  INDEX_DOCUMENT=$(package_index_file)
  FRAMEWORK=$(package_framework)
  PHP_EXTRA_CONFIG=$(package_php_config)
  PHP_INCLUDES=$(package_php_includes)
  COMPILE_CMD=$(package_compile_cmd)
  NGINX_INCLUDES=$(package_nginx_includes)
  NGINX_LOCATIONS=$(package_nginx_locations)
  USER_LOG_FILES=$(package_log_files)
  DOCUMENT_ROOT="$(package_document_root)"

  echo $PHP_VERSION
  echo $NGINX_VERSION
  echo $FRAMEWORK

  # generate nginx config

  export PORT=80
  erb "$GENERATOR_DIR/templates/nginx/00-defaults.conf.erb" > "$BUILD_DIR/server-config/nginx/conf.d/00-defaults.conf"
  erb "$GENERATOR_DIR/templates/nginx/project.conf.erb" > "$BUILD_DIR/server-config/nginx/conf.d/project.conf"

  # generate php-fpm config
  #
  # /dist/composer.json > build/php-fpm.conf
  # generate base nginx config /dist/composer.json > build/nginx.conf
  # project-specific nginx config /dist/composer.json > build/site.conf
  # generate installation of deps command > build/install-production-deps.sh

  for var in $(env | cut -f1 -d=); do
      echo "env[$var] = \$${var}" >> $BUILD_DIR/server-config/php/conf.d/env.ini
  done

  # TODO: New relic
  #erb "$GENERATOR_DIR/templates/php/project.conf.erb" > "$BUILD_DIR/server-config/php/conf.d/newrelic.ini"

  # TODO: Move to runtime instead
  #if [ -n "\$NEW_RELIC_LICENSE_KEY" ]; then
  #    echo "newrelic.license=\"\$NEW_RELIC_LICENSE_KEY\"" > $BUILD_DIR/server-config/php/conf.d/newrelic_license.ini
  #fi

  rm "$BUILD_DIR/server-config/php/conf.d/project.ini"
  for conf in $PHP_EXTRA_CONFIG; do
      echo "$conf" >> "$BUILD_DIR/server-config/php/conf.d/project.ini"
  done

  for include in $PHP_INCLUDES; do
      cp "$BUILD_DIR/$include" "/app/vendor/php/etc/conf.d/"
  done

else
  echo "No composer.json found in BUILD_DIR";
  exit 1
fi