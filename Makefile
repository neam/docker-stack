.PHONY: all build default release

default: build

all: build

build-schmunk42: php-nginx yii2 phundament

php-nginx:
	docker build -t schmunk42/nginx:1.7          images/php-nginx/nginx
	docker build -t schmunk42/php:5.6-fpm        images/php-nginx/php-fpm

yii2: php-nginx
	docker build -t schmunk42/php:5.6-fpm-yii-2.0.3-runtime         images/php-nginx.yii2/php-fpm-runtime
	docker build -t schmunk42/php:5.6-cli-yii-2.0.3-runtime         images/php-nginx.yii2/php-cli-runtime
	docker build -t schmunk42/php:5.6-cli-yii-2.0.3-app-basic       images/php-nginx.yii2/php-cli-app-basic
	# TODO: build process hangs with hhvm image --- docker build -t schmunk42/hhvm:3.5-cli-yii-2.0.3-app-basic      images/php-nginx.yii2/hhvm-cli-app-basic

phundament: yii2
	docker build -t phundament/php:5.6-fpm-4.0.0         images/php-nginx.yii2.phundament/php-fpm
	docker build -t phundament/php:5.6-cli-4.0.0-prod    images/php-nginx.yii2.phundament/php-cli-prod
	docker build -t phundament/php:5.6-cli-4.0.0-dev     images/php-nginx.yii2.phundament/php-cli-dev

test: test-stack-php-nginx-vanilla-mount test-stack-php-nginx

test-stack-php-nginx-vanilla-mount:
	cd stacks/php-nginx-vanilla && \
	    docker-compose build && \
	    docker-compose up -d && \
	    docker-compose ps && \
	    docker-compose run cli env && \
	    docker-compose stop

test-stack-php-nginx:
	cd stacks/php-nginx && \
		docker-compose build && \
	    docker-compose run cli php -v && \
	    docker-compose up -d && \
	    docker-compose ps && \
	    docker-compose run cli env && \
	    docker-compose stop

test-phundament:
	cd stacks/php-nginx.yii2.phundament && \
	    docker-compose build && \
	    docker-compose up -d && \
	    docker-compose stop

release-schmunk42: build-schmunk42
	echo "Pushing images to Docker Hub..."
	docker push schmunk42/nginx
	docker push schmunk42/php
	# TODO: see above -- docker push schmunk42/hhvm
	docker push phundament/php

build-neam: debian-php-nginx neam.php-app-images

debian-php-nginx:
	docker build -t neam/debian-php:5.6.7-fpm         images/debian-php-nginx/php-fpm

neam.php-app-images: debian-php-nginx
	docker build -t neam/php-app-builder                      images/neam.php-app-builder
	docker build -t neam/php-app-tester                       images/neam.php-app-tester
	docker build -t neam/php-app-worker:tutum-debian-jessie   images/neam.php-app-worker

neam.dna-project-base: debian-php-nginx
  docker build -t neam/dna-project-base-debian-php:5.6.7-fpm  stacks/debian-php-nginx.dna-project-base/stack/php/image

release-neam: build-neam
	echo "Pushing images to Docker Hub..."
	docker push neam/debian-php:5.6.7-fpm
	docker push neam/php-app-builder
	docker push neam/php-app-tester
	docker push neam/php-app-worker:tutum-debian-jessie
	docker push neam/dna-project-base-debian-php:5.6.7-fpm
