Installation
------------

To install docker-stack cli in your home directory and make it available in PATH when using bash: 

    git clone https://github.com/neam/docker-stack ~/.docker-stack
    echo 'export PATH=$PATH:~/.docker-stack/cli' >> ~/.bash_profile
    source ~/.bash_profile


Requirements
------------

 * docker 1.8.3+
 * docker-compose 1.4.2+
 * git
 * a *nix shell (Windows users: Try Cygwin or Git bash)


Quick start
---------------------------

### PHP+Nginx+Database Hello World

Create a blank project, install and start the PHP+Nginx+Database stack:

    mkdir myapp
    cd myapp
    docker-stack install debian-php-nginx.database
    docker-compose up -d
    
Then visit the URL displayed by running the following command:
    
    docker-stack local url /stack-hello.url

> Hint: On OSX, you can open the url directly from a terminal session:
>
>    open $(docker-stack local url)


### Yii 2 (without a database connection)

To try out running Yii 2 locally using Docker:

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
