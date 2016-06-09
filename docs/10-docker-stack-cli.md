Installation
------------

Install docker-stack cli in your home directory and make it available in PATH when using bash: 

    git clone https://github.com/neam/docker-stack ~/.docker-stack
    echo 'export PATH=$PATH:~/.docker-stack/cli' >> ~/.bash_profile
    source ~/.bash_profile

If you already have docker-stack installed, you can update it by running:

    cd ~/.docker-stack
    git pull


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


Adopting a Docker stack
-----------------------

## Test drive a stack

List available stacks:

    docker-stack list

Select a stack:

    docker-stack select <stack-name>

Fire up the stack:

    docker-compose up -d
    docker-stack local url

Any other necessary instructions (if any) are found in each stack's README.

Note: Your app needs to be configured to use environment variables for configuration of backing services.

## Customize your stack

You can either fork the docker-stack repository and customize the files directly, or install a copy of the stack to your app repository:

    docker-stack install <stack-name>

## The .docker-stack file

The .docker-stack file is found in every stack and contains paths to the different yaml files used to describe the stack:
 
 * `LOCAL_STACK_YML` - Docker compose configuration file for local development
 * `PRODUCTION_STACK_YML` - Docker compose configuration file for portable deployment of the app on any docker host
 * `DOCKERCLOUD_STACK_YML` - Tutum stack yaml configuration file for portable deployment of the app using Tutum

## The general structure of existing stacks found in this repo

 * `stack/README.md` - The stack's README
 * `stack/{container-type}/*` - Configuration files used by your stack's containers
 
The container that exposes port 80 to the end-user should be called `web`.

Sample stack boilerplate files are found in this repository under `../stacks/`, documented in [the main README.md](../README.md#stacks).
