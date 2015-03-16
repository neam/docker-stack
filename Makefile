.PHONY: all build default release

default: build

all: build

build: php-nginx yii2 phundament

php-nginx:
	docker build -t schmunk42/nginx:1.7          images/php-nginx/nginx
	docker build -t schmunk42/php:5.6-fpm        images/php-nginx/php-fpm

yii2: php-nginx
	docker build -t schmunk42/php:5.6-fpm-yii-2.0.3-runtime         images/php-nginx.yii2/php-fpm-runtime
	docker build -t schmunk42/php:5.6-cli-yii-2.0.3-runtime         images/php-nginx.yii2/php-cli-runtime
	docker build -t schmunk42/php:5.6-cli-yii-2.0.3-app-basic       images/php-nginx.yii2/php-cli-app-basic
	docker build -t schmunk42/hhvm:3.5-cli-yii-2.0.3-app-basic      images/php-nginx.yii2/hhvm-cli-app-basic

phundament: yii2
	docker build -t phundament/php:5.6-fpm-4.0.0         images/php-nginx.yii2.phundament/php-fpm
	docker build -t phundament/php:5.6-cli-4.0.0-prod    images/php-nginx.yii2.phundament/php-cli-prod
	docker build -t phundament/php:5.6-cli-4.0.0-dev     images/php-nginx.yii2.phundament/php-cli-dev

test: test-stack-php-nginx-vanilla-mount test-stack-php-nginx

test-stack-php-nginx-vanilla-mount:
	cd stacks/php-nginx && \
	    docker-compose -f docker-compose-vanilla-mount.yml run cli php -v && \
	    docker-compose -f docker-compose-vanilla-mount.yml up -d && \
	    docker-compose -f docker-compose-vanilla-mount.yml run fpm env && \
	    docker-compose -f docker-compose-vanilla-mount.yml run web env && \
	    docker-compose -f docker-compose-vanilla-mount.yml stop

test-stack-php-nginx:
	cd stacks/php-nginx && \
	    docker-compose run cli php -v && \
	    docker-compose up -d && \
	    docker-compose run fpm enmakev && \
	    docker-compose run web env && \
	    docker-compose stop

test-phundament:
	cd stacks/php-nginx.yii2.phundament && \
	    docker-compose build && \
	    docker-compose up -d && \
	    docker-compose stop

release: build
	echo "Pushing images to Docker Hub..."
	docker push schmunk42/nginx
	docker push schmunk42/php
	docker push schmunk42/hhvm
	docker push phundament/php
