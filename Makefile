.PHONY: all build default release

default: build

all: build

build: yii2 phundament

php-nginx:
	cd stacks/php-nginx && \
	    docker-compose run cli php -v && \
	    docker-compose up -d && \
	    docker-compose stop

yii2:
	docker build -t schmunk42/php-yii2:cli stacks/yii2/stack/php-cli
	docker build -t schmunk42/php-yii2:fpm stacks/yii2/stack/php-fpm

phundament: yii2
	docker build -t phundament/php:cli stacks/phundament/stack/php-cli
	docker build -t phundament/php:fpm stacks/phundament/stack/php-fpm

release: build
	echo "NOT IMPLEMENTED YET"