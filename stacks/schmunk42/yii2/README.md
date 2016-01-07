Yii 2 Docker Stack
==================

# Dockerize

## Option A: From image

    docker pull schmunk42/php:5.6-cli-yii-2.0.3-app-basic

Copy files

    mkdir myapp
    cd myapp
    docker run -v `pwd`:/install schmunk42/php:5.6-cli-yii-2.0.3-app-basic cp -r /app/. /install

## Option B: From clone

To dockerize a Yii 2 application, get a 2.0.3 verion for example:

    git clone -b 2.0.3 https://github.com/yiisoft/yii2-app-basic.git myapp

# Startup
    
Get Dockerization files    
      
    curl -O https://raw.githubusercontent.com/neam/docker-stack/develop/stacks/yii2/docker-compose.yml
    curl -O https://raw.githubusercontent.com/neam/docker-stack/develop/stacks/yii2/.dockerignore
    curl -O https://raw.githubusercontent.com/neam/docker-stack/develop/stacks/yii2/Dockerfile

Install application packages (required only for Option B)

    docker-compose run cli composer install --prefer-dist
   
Bring up the services
   
    docker-compose up -d

Check the assigned ports

    docker-compose ps

Output should look similar to

        Name                  Command              State                Ports              
    --------------------------------------------------------------------------------------
    myapp_cli_1   php -a                         Exit 0                                  
    myapp_db_1    /docker-entrypoint.sh mysqld   Up       0.0.0.0:49391->3306/tcp        
    myapp_fpm_1   /root/run.sh                   Up       9000/tcp                       
    myapp_web_1   /root/run.sh                   Up       443/tcp, 0.0.0.0:49390->80/tcp 

> *Temporary Glitch*
> 
>     edit config/web.php

Open application in browser, check on which port `myapp_web_1` is accessible on the Docker host.

    open http://192.168.59.103:49390

Follow the logs

    docker-compose logs

# Develop

Find the port by inspecting the output of docker-compose ps
open up http://DOCKER_HOST_IP:PORT in your browser, or by running:

    docker-stack url

To edit Nginx configuration, first copy the existing nginx.conf to your local directory:

    docker-compose run web cat /etc/nginx/nginx.conf > nginx.conf

Edit it and add the following volume to your docker-compose.yml:

    volumes:
     - ./nginx.conf:/etc/nginx/nginx.conf

# Deploy

Build with project name and tag image   
   
    docker-compose -p myapp build
    docker tag myapp_cli tutum.com/username/myapp:cli

Create a tutum (production) stack    
    
    cp docker-compose.yml docker-compose-tutum.yml

Update `image: tutum.com/username/myapp:cli` and `volumes_from`.
    
    edit docker-compose-tutum.yml
    
Push image 

    docker tag myapp_cli tutum.com/username/myapp:cli
    
Drag & upload stack to tutum.    