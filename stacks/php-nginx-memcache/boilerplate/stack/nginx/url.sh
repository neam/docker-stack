#!/bin/bash

    export DOCKER_HOST_IP=$(echo $DOCKER_HOST | sed 's/tcp:\/\///' | sed 's/:[0-9.]*//')
    export NGINX_PORT_80=$(docker-compose port nginx 80 | sed 's/[0-9.]*://')
    export URL="http://$DOCKER_HOST_IP:$NGINX_PORT_80"

    echo $URL
