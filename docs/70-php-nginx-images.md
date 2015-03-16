# PHP + nginx Docker images

> Note: `cli` containers also contain the application data, which is shared via `volumes_from`.


## Base

### `schmunk/php`

Basic PHP + nginx configuration

- `5.6-cli`
- `5.6-fpm` 

## Yiisoft

### `schmunk/php`

Framework runtime

- `5.6-fpm-2.0.3-yii-runtime`
- `5.6-cli-2.0.3-yii-runtime`

Applications

- `5.6-cli-2.0.3-app-basic`


## Phundament

## `phundament/php`

- `5.6-cli-4.0.0-prod` Phundament 4 Application
- `5.6-cli-4.0.0-dev` Phundament 4 Application with development packages (eg. closure-compiler, code-generation)