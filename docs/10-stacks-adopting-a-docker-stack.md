Stacks - Adopting a Docker stack
=======================

## Test drive a stack

List available stacks:

    docker-stack list

Select a stack:

    docker-stack select <stack-name>

Fire up the stack:

    docker-compose start
    docker-stack local url

Any other necessary instructions (if any) are found in each stack's README.

Note: Your app needs to be configured to use environment variables for configuration of backing services.

## Customize your stack

You can either fork the docker-stack repository and customize the files directly, or install a copy of the stack to your app repository:

    docker-stack install <stack-name>

## The general structure of existing stacks found in this repo

 * `docker-compose.yml` or `stack/local.yml` - Docker compose configuration file for local development
 * `stack/deploy.yml` - Docker compose configuration file for portable deployment of the app on any docker host
 * `stack/deploy-tutum.yml` - Docker compose configuration file for portable deployment of the app using Tutum
 * `stack/{container-type}/*` - Project-specific configuration files used by your stack
 * `stack/codebase/install-deps.sh` - Project-specific script for installation of dependencies

The container that exposes port 80 to the end-user should be called `web`.

Sample stack boilerplate files are found in this repository under `../stacks/`, documented in [the main README.md](../README.md#stacks).
