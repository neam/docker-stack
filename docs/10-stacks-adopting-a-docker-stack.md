Stacks - Adopting a Docker stack
=======================

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
 * `TUTUM_STACK_YML` - Tutum stack yaml configuration file for portable deployment of the app using Tutum

## The general structure of existing stacks found in this repo

 * `stack/README.md` - The stack's README
 * `stack/{container-type}/*` - Configuration files used by your stack's containers
 
The container that exposes port 80 to the end-user should be called `web`.

Sample stack boilerplate files are found in this repository under `../stacks/`, documented in [the main README.md](../README.md#stacks).
