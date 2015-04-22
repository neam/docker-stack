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

phundament: export version=4.0.0-beta13.1
phundament: yii2
	docker build -t phundament/php:5.6-fpm-$(version)         images/php-nginx.yii2.phundament/php-fpm
	docker build -t phundament/php:5.6-cli-$(version)-prod    images/php-nginx.yii2.phundament/php-cli-prod
	docker build -t phundament/php:5.6-cli-$(version)-dev     images/php-nginx.yii2.phundament/php-cli-dev
	docker tag -f phundament/php:5.6-cli-$(version)-dev phundament/php:latest

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
	    curl http://$(DOCKER_HOST_IP):`docker-compose web nginx` && \
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
	docker build -t neam/php-app-builder  images/neam.php-app-builder
	docker build -t neam/php-app-tester   images/neam.php-app-tester
	docker build -t neam/php-app-worker   images/neam.php-app-worker

neam.dna-project-base: debian-php-nginx
  docker build -t neam/dna-project-base-debian-php:5.6.7-fpm  stacks/debian-php-nginx.dna-project-base/stack/php/image

release-neam: export version=0.2.0
release-neam: build-neam
	echo "Tagging neam images as version $(version)"
	docker tag -f neam/debian-php:5.6.7-fpm neam/debian-php:5.6.7-fpm-$(version)
	docker tag -f neam/php-app-builder neam/php-app-builder:$(version)
	docker tag -f neam/php-app-tester neam/php-app-tester:$(version)
	docker tag -f neam/php-app-worker neam/php-app-worker:$(version)
	docker tag -f neam/dna-project-base-debian-php:5.6.7-fpm neam/dna-project-base-debian-php:5.6.7-fpm-$(version)
	echo "Pushing neam images to Docker Hub..."
	docker push neam/debian-php:5.6.7-fpm-$(version)
	docker push neam/php-app-builder:$(version)
	docker push neam/php-app-tester:$(version)
	docker push neam/php-app-worker:$(version)
	docker push neam/dna-project-base-debian-php:5.6.7-fpm-$(version)
