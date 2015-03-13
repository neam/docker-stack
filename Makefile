.PHONY: all build default release

default: build

all: build

build: php-nginx yii2 phundament

php-nginx:
	docker build -t schmunk42/php:5.6-fpm stacks/php-nginx/stack/php-fpm
	docker build -t schmunk42/php:5.6-cli stacks/php-nginx/stack/php-cli
	docker build -t schmunk42/nginx:1.7 stacks/php-nginx/stack/nginx

yii2: php-nginx
	docker build -t schmunk42/php-yii2:5.6-cli stacks/yii2/stack/php-cli
	docker build -t schmunk42/php-yii2:5.6-fpm stacks/yii2/stack/php-fpm

phundament: yii2
	docker build -t phundament/php:5.6-cli-4.0.0 stacks/phundament/stack/php-cli
	docker build -t phundament/php:5.6-cli stacks/phundament/stack/php-cli
	docker build -t phundament/php:5.6-fpm stacks/phundament/stack/php-fpm
	docker build -t phundament/nginx:1.7 stacks/phundament/stack/nginx

test: test-stack-php-nginx-vanilla-mount test-stack-php-nginx

test-stack-php-nginx-vanilla-mount:
	cd stacks/php-nginx && \
	    docker-compose -f docker-compose-vanilla-mount.yml run cli php -v && \
	    docker-compose -f docker-compose-vanilla-mount.yml up -d && \
	    docker-compose -f docker-compose-vanilla-mount.yml run php env && \
	    docker-compose -f docker-compose-vanilla-mount.yml run web env && \
	    docker-compose -f docker-compose-vanilla-mount.yml stop

test-stack-php-nginx:
	cd stacks/php-nginx && \
	    docker-compose -f docker-compose-vanilla-mount.yml run cli php -v && \
	    docker-compose -f docker-compose-vanilla-mount.yml up -d && \
	    docker-compose -f docker-compose-vanilla-mount.yml run php env && \
	    docker-compose -f docker-compose-vanilla-mount.yml run web env && \
	    docker-compose -f docker-compose-vanilla-mount.yml stop

release: build
	echo "Pushing images to Docker Hub..."
	docker push schmunk42/php
	docker push schmunk42/php-yii2
	docker push phundament/php