# PHP + nginx Docker images

This document contains a description of the available PHP and HHVM images from this repository.

> Note: `cli` containers also contain the application data, which is shared via `volumes_from`.

## Base

### [`schmunk42/nginx`](https://registry.hub.docker.com/u/schmunk42/nginx/)

Basic nginx configuration

- `1.7`

### [`schmunk42/php`](https://registry.hub.docker.com/u/schmunk42/php/)

Basic PHP-FPM configuration

- `5.6-cli`
- `5.6-fpm` 


## Yiisoft

### [`schmunk42/php`](https://registry.hub.docker.com/u/schmunk42/php/)

#### Framework runtime

- `5.6-fpm-2.0.3-yii-runtime`
- `5.6-cli-2.0.3-yii-runtime`

#### Applications

Available for initial installation by copying from `/app-src`.

- `5.6-cli-2.0.3-yii-app-basic`

### [`schmunk42/hhvm`](https://registry.hub.docker.com/u/schmunk42/hhvm/)

Framework runtime (`fpm`) can be used directly from [estebanmatias92/docker-hhvm](https://github.com/estebanmatias92/docker-hhvm),
since these images contain all required PHP extensions.

Applications

- `3.5-cli-2.0.3-yii-app-basic`


## Phundament

### [`phundament/php`](https://registry.hub.docker.com/u/phundament/php/)

Available for initial installation by copying from `/app-src`.

- `5.6-cli-4.0.0-prod` Phundament 4 Application CLI (and data container)
- `5.6-cli-4.0.0-dev` Phundament 4 Application with development packages (eg. closure-compiler, code-generation) aka. "builder"
- `5.6-fpm-4.0.0` Phundament 4 Application with development settings
