Stacks Overview
===============

The following files needs to be available in your app repository to be able to utilize the workflows described in this repo:

    `docker-compose.yml` - Docker compose configuration file for local development
    `stack/{container}/*` - Project-specific configuration files used by your stack
    `stack/deploy.yml` - Docker compose configuration file for portable deployment of the app on any docker host
    `stack/deploy-tutum.yml` - Docker compose configuration file for portable deployment of the app using Tutum

Sample stack boilerplate files are found in this repository under `./stacks/`.
