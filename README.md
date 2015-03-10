Docker PHP Toolkit
=================================

Toolkit for maintaining a Docker-based "one-process-per-container" PHP-FPM/Nginx stack for 12-factor PHP apps.

Includes:
 * Boilerplate files to include in your 12-factor app
 * The Dockerfile and assets for the PHP-FPM an Nginx server configuration generator for generating configuration based on your composer.json
 * Some potentially useful shell scripts

## Installation

Clone this repository and copy the boilerplate files to your 12-factor app base dir.

Add your project php/nginx configuration includes to the `stack/nginx/` and `stack/php/` directories.

## Usage - Local Development

### Step 1

Install Docker 1.5.0 and [Docker Compose](https://docs.docker.com/compose/install/)

### Step 2

Prepare `vendor` folder for development using the Docker shell (or `dosh` in short):

    docker-compose run -it dosh composer install

### Step 3

Fire up your local docker stack:

    docker-compose up

Find out the port your nginx container is responding on:

    export NGINX_PORT=$(docker-compose ps nginx | tail -n1 | awk '{ print $5 }' | sed 's/[0-9.]*://' | sed 's/->80\/tcp//')

Open http://$DOCKER_HOST_IP:$NGINX_PORT in your browser and hack away!

## Deployment

Build deployment images

    docker build -f .stack.files.Dockerfile -t ${APP_ID}:${BRANCH} .
    docker push

Deploy - on your docker host:

    git clone https://example.com/project.git
    cd project
    docker-compose -f stack/deploy.yml up -d

Or, on tutum:

    tutum stack create -n ${APP_ID} -f build/tutum.yml


