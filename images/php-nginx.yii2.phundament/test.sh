#!/usr/bin/env bash

set -e

docker run --rm phundament/php ls -la /phundament-src
docker run --rm phundament/php sh -c 'cd /phundament-src && cp .env-dist .env && ./yii'
docker run --rm phundament/php sh -c 'cd /phundament-src && cp .env-dist .env && ./yii help app'

docker run --rm phundament/php:5.6-fpm-dev sh -c 'lessc'
