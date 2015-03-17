Base images stack
=================

Using official (vanilla) images, configuration is added by volumes.

    cd stacks/php-nginx-vanilla
    docker-compose up -d
    docker-compose ps

Usually you will build `FROM` these images, the stack is just for demo and testing.

    docker composer up -d
    
    docker composer ps
    
    docker composer logs