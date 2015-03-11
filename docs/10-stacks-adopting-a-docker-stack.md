Stacks - Adopting a Docker stack
=======================

The following files needs to be available in your app repository to be able to utilize the workflows described in this repo:

 * `docker-compose.yml` - Docker compose configuration file for local development
 * `stack/{container-type}/*` - Project-specific configuration files used by your stack
 * `stack/codebase/install-deps.sh` - Project-specific script for installation of dependencies
 * `stack/deploy.yml` - Docker compose configuration file for portable deployment of the app on any docker host
 * `stack/deploy-tutum.yml` - Docker compose configuration file for portable deployment of the app using Tutum

The container that exposes port 80 to the end-user should be called `web`.

Sample stack boilerplate files are found in this repository under `../stacks/`, documented in [the main README.md](../README.md#stacks).
