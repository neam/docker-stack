Installation
------------

Clone and symlink to /usr/local/bin/:

    git clone https://github.com/neam/docker-stack
    cd docker-stack
    ln -s $(pwd)/cli/docker-stack /usr/local/bin/docker-stack


Quick start - Example Yii 2
---------------------------

    composer create-project --prefer-dist yiisoft/yii2-app-basic:2.0.3 myapp
    cd myapp
    docker-stack install yii2
    docker-compose up -d
    docker-stack local url

> Hint: On OSX, you can open the url directly from a terminal session:
>
>    open $(docker-stack local url)

Usage
-----

Cd into your app directory:

    cd myapp

List available stacks:

    docker-stack list

Select or install a stack:

    docker-stack select <stack-name>
    docker-stack install <stack-name>

Fire up the stack locally:

    docker-compose up -d

Visit the below returned url in your browser:

    docker-stack local url

> Hint: On OSX, you can open the url directly from a terminal session:
>
>    open $(docker-stack local url)

Build images for production deployment:

    docker-stack production build

Push built images:

    docker-stack production build

On a production docker host:

    git clone myapp.git
    cd myapp
    docker-stack production start