Docker Stack
============

> **Active development disclaimer**: Code is still being moved around and being updated while preparing for a stable release. That said, the stacks stemming from this project have been verified to work well for both local development and high availability multi-node setups deployed at AWS, Digital Ocean and Azure via [the container platform service Tutum](https://tutum.io)


Develop, Build, Test, Deploy and Maintain your 12-factor web app using Docker
-----------------------------------------------------------------------------

Uses [Docker Compose, Docker Machine and Docker 1.5.0+](http://blog.docker.com/2014/12/announcing-docker-machine-swarm-and-compose-for-orchestrating-distributed-apps/) to maintain a Docker-based "one-process-per-container" stack and development workflows for your 12-factor web apps.

Enables easy app-specific orchestration of dockerized services (databases, mail servers, task runners, message queues etc)

The stack can be deployed to any docker host/swarm or orchestrated via [the container platform service Tutum](https://tutum.com).

Requirements
------------

 * docker 1.5.0+
 * docker-compose
 * make
 * git
 * a *nix shell (Windows users: Try Cygwin or Git bash)

What is a stack?
----------------

> A stack is a collection of services that make up an application in a specific environment. A stack file is a file in YAML format that define one or more services. The YAML reference is documented here.

> A stack is a convenient way to automate the deployment of multiple services that are linked to each other, without the need to define one by one.

> As stack files also define environment variables and related environment-specific configuration, it is recommended to use one stack file per environment (dev, test, prod...).

See [tutum documentation](https://support.tutum.co/support/solutions/articles/5000569899-stacks)


Why `docker-stack`?
-------------------

As a member of a developer team, the stack enables you to ditch Vagrant/Puppet/Chef while still maintaining a cross-platform local development workflow similar to the powerful `npm install` + `grunt serve` combo for javascript-based apps:

    docker-compose run shell composer install
    docker-compose up

Includes sample documentation on how to use the stack for a wide range of web app development workflows, ranging from setting up the project for new developers to debugging software bugs in production.


Command-line tools
------------------

> Note as of June 2015, the command-line tools are in alpha stage.

### `docker-stack` CLI

This section includes instructions for using/adopting docker-based stacks for your 12-factor web app.

- [Overview](docs/10-docker-stack-cli.md)
- [Adopting a Docker stack](docs/10-stacks-adopting-a-docker-stack.md)
- [Generating Nginx & PHP Configuration](generators/nginx-php-server-config-generator/README.md)

### doma Makefile temples

Control your stacks and applications with `Makefile` templates for `docker`, `docker-composer`, `tutum`, `aws-s3` or `mysql`.

For full documentation see [GitHub](https://github.com/schmunk42/doma) Repository.


Available Stacks
----------------

- [Hello World](stacks/hello-world/README.md)
- [PHP/Nginx](stacks/php-nginx/README.md)
- [Vanilla PHP/Nginx](stacks/php-nginx-vanilla/README.md)
- [Debian PHP/Nginx/Memcache](stacks/debian-php-nginx.memcache/README.md)
- [Yii 2.0 Framework](stacks/yii2/README.md)
- [DNA Project Base](stacks/debian-php-nginx.memcache.dna-project-base/README.md)

Develop
-------

This section includes boilerplate documentation for developers to hack on a project that has adopted a docker-based stack. It is meant to be copied to your app repository and adapted to suit your specific workflows.

- [First-time set-up](docs/20-local-dev-first-time-set-up.md)
- TODO: [Working with secrets](docs/22-local-dev-working-with-secrets.md)
- TODO: [Working with database data](docs/23-local-dev-working-with-database-data.md)
- TODO: [Working with tests](docs/24-local-dev-working-with-tests.md)
- TODO: [Code generation](docs/25-local-dev-code-generation.md)
- [Pulling in changes from team mates](docs/21-local-dev-pulling-in-changes-from-team-mates.md)


Distribute
----------

This section includes boilerplate documentation on how to package and deploy your 12-factor web app for deployment elsewhere. It is meant to be copied to your app repository and adapted to suit your specific workflows.

- [Build and push](docs/51-distribute-build-and-push.md)
- TODO: [Deploy](docs/52-distribute-deploy.md)


Release Management
------------------

This section includes boilerplate documentation on how to update and troubleshoot your 12-factor web app in production. It is meant to be copied to your app repository and adapted to suit your specific workflows.

- TODO: [Production release routines](docs/60-release-routines.md)
- TODO: [Live troubleshooting](docs/61-live-troubleshooting.md)
- TODO: [If something is wrong with the latest release](docs/62-if-something-is-wrong-with-the-latest-release.md)
- TODO: [Staging new features](docs/63-staging-new-features.md)


Misc
----

- [Installing Docker Stack in your project](docs/80-misc-installing-docker-stack-in-your-project.md)

Development of Docker Stack
---------------------------

- [Building Docker Stack Images](docs/71-building-docker-stack-images.md)


License
-------

MIT