#!/bin/sh

echo "Building images..."

docker -D build -t schmunk42/php-yii2:cli yii2/php/cli
docker -D build -t schmunk42/php-yii2:fpm yii2/php/fpm

docker -D build -t phundament/php:cli phundament/php/cli
docker -D build -t phundament/php:fpm phundament/php/fpm

