Yii 2 Docker Stack
==================

To dockerize a Yii 2 application, example:

    git clone https://github.com/yiisoft/yii2-app-basic.git
    curl -O https://raw.githubusercontent.com/neam/docker-stack/develop/stacks/yii2/docker-compose.yml
    curl -O https://raw.githubusercontent.com/neam/docker-stack/develop/stacks/yii2/.dockerignore
    docker-compose run cli composer install
    docker-compose up

Find the port by inspecting the output of docker-compose ps
open up http://DOCKER_HOST_IP:PORT in your browser, or by running:

    docker-stack url

To edit Nginx configuration, first copy the existing nginx.conf to your local directory:

    docker-compose run web cat /etc/nginx/nginx.conf > nginx.conf

Edit it and add the following volume to your docker-compose.yml:

    volumes:
     - ./nginx.conf:/etc/nginx/nginx.conf

# Deploy

Create a Dockerfile with the following contents:

    FROM schmunk42/php:5.6-cli-yii-2.0.3-app-basic
    ADD . /app
    # Do the following for custom files you are overriding in your app, if any:
    ADD nginx.conf /etc/nginx/nginx.conf
