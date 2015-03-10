#!/bin/bash

set -e
set -o pipefail
shopt -s dotglob

if [ "$APP_DIR" == "" ]; then
    echo "APP_DIR must be set. (to a directory where the app's main composer.json resides)"
    exit;
fi

BUILD_DIR="$APP_DIR"

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

function package_index_document() {
    jq --raw-output ".extra.${composer_extra_key}[\"index-document\"] // \"index.php index.html\"" < "$BUILD_DIR/composer.json"
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
    jq --raw-output ".extra.${composer_extra_key}[\"nginx-locations\"] // []" < "$BUILD_DIR/composer.json"
}

function package_log_files() {
    jq --raw-output ".extra.${composer_extra_key}[\"log-files\"] // [] | .[]" < "$BUILD_DIR/composer.json"
}

function package_compile_cmd() {
    jq --raw-output ".extra.${composer_extra_key}[\"compile\"] // [] | .[]" < "$BUILD_DIR/composer.json"
}

function package_newrelic_enabled() {
    jq --raw-output ".extra.${composer_extra_key}[\"newrelic\"] // false" < "$BUILD_DIR/composer.json"
}

# Read config variables from composer.json if it exists
if [ -f "$BUILD_DIR/composer.json" ]; then

  status "Parsing composer.json"

  composer_extra_key="server"
  if [ -n "$(has_heroku_extra)" ] ; then
    protip "Your composer.json is using the key 'extra' → 'heroku', you should switch to 'extra' → 'server' if this project does not work on heroku"
    composer_extra_key="heroku"
  fi

  # note about php and nginx versions
  if [ -n "$(package_php_version)" ] ; then
    protip "Your composer.json specifies a specific PHP version. This is ignored by the server config generator - instead, the actual PHP version of your app is specified by the php-fpm docker image the app defines in it's docker-compose.yml"
  fi

  if [ -n "$(package_nginx_version)" ] ; then
    protip "Your composer.json specifies a specific Nginx version. This is ignored by the server config generator - instead, the actual Nginx version of your app is specified by the nginx docker image the app defines in it's docker-compose.yml"
  fi

  PHP_VERSION="$(package_php_version)"
  NGINX_VERSION="$(package_nginx_version)"
  DOCUMENT_ROOT="$(package_document_root)"
  INDEX_DOCUMENT="$(package_index_document)"
  FRAMEWORK="$(package_framework)"
  PHP_EXTRA_CONFIG="$(package_php_config)"
  PHP_INCLUDES="$(package_php_includes)"
  COMPILE_CMD="$(package_compile_cmd)"
  NGINX_INCLUDES="$(package_nginx_includes)"
  NGINX_LOCATIONS="$(package_nginx_locations)"
  USER_LOG_FILES="$(package_log_files)"
  DOCUMENT_ROOT="$(package_document_root)"
  NEWRELIC_ENABLED="$(package_newrelic_enabled)"

  # Serialize the data
  typeset -p PHP_VERSION NGINX_VERSION DOCUMENT_ROOT INDEX_DOCUMENT FRAMEWORK PHP_EXTRA_CONFIG PHP_INCLUDES COMPILE_CMD NGINX_INCLUDES NGINX_LOCATIONS USER_LOG_FILES DOCUMENT_ROOT NEWRELIC_ENABLED > "$BUILD_DIR/server-config/.serialized_composer_json_data.sh"

  status "Done! Results saved in $BUILD_DIR/server-config/.serialized_composer_json_data.sh"

else
  status "No composer.json found in $BUILD_DIR, automatic server config generation will not be performed";
fi
