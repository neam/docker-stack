Docker Stack
============

This project is dedicated to maintain a couple of best-practice Docker-based stacks and related images that can be used and adapted by your projects, or act as a reference point and inspiration when you set up your own Docker-based stack architecture.

The core stacks in this project have been verified to work well for both local development and high performance multi-node setups deployed at AWS using [Docker Cloud](https://cloud.docker.com).


Develop, Build, Test, Deploy and Maintain your 12-factor web app using Docker
-----------------------------------------------------------------------------

Uses [Docker Toolbox](https://www.docker.com/products/docker-toolbox) to maintain a base-practice Docker-based "one-process-per-container" stack and development workflows for your [12-factor web apps](http://12factor.net/).

Enables easy app-specific orchestration of dockerized services (databases, mail servers, task runners, message queues etc).


Requirements
------------

 * docker 1.8.3 (1.11.1+ recommended)
 * docker-compose 1.4.2 (1.7.1+ recommended)
 * git


Why use a Docker-based stack in the first place?
-------------------

As a member of a developer team, the Docker-based stack enables you to ditch Vagrant/Puppet/Chef while still maintaining a cross-platform local development workflow similar to the powerful `npm install` + `grunt serve` combo for javascript-based apps:

    docker-compose run --rm worker composer install
    docker-compose up

Thus, in any team or project where multiple developers are involved, less time and hassle is necessary to get the project software running locally.

The stack can then be deployed to any docker host/swarm or orchestrated via [Docker Cloud](https://cloud.docker.com), providing a high degree of dev/prod parity:

Why `docker-stack`?
-------------------

Setting up, configuring and maintaining a Docker-based stack takes time, and docker-stack makes it possible to re-use existing stack configurations which empowers [the 12-factor web app](http://12factor.net/). 

Care has been taken to make all vital configuration files visible and easy customizable, so that it is straightforward to tweak, adjust and debug configuration issues.

Core Stacks
----------------

### Publisher: neam

These stacks and underlying concepts are used in production by [Neam Labs](http://neamlabs.com) and are [constantly tweaked to be faster and more reliable](./CHANGELOG.md).

- [Debian PHP/Nginx](stacks/neam/debian-php-nginx/stack/README.md)
- [Debian PHP/Nginx + Database (LEMP)](stacks/neam/debian-php-nginx/stack/README.md)
- [DNA Project Base Stack (Based on Debian PHP/Nginx + Database)](stacks/neam/debian-php-nginx.dna-project-base/stack/README.md)


Miscellaneous Stacks
----------------

### Publisher: neam

- [Hello World](stacks/neam/hello-world/stack/README.md)
- [Docker Cloud / Tutum HAProxy Virtual Host Proof-of-concept](stacks/neam/text-to-flowchart-generators-haproxy-vhost-example/README.md)


Command-line tools
------------------

There are three main ways to interact with a Docker-based once installed in your project:
 * `docker-compose` 

Read more about them below.

### `docker-compose`

Docker Compose is the heart of Docker Stack. Once a stack is installed in your project folder (and thus a docker-compose.yml file is present), docker-compose can be used "as usual".


Configuration Generators included in Docker Stack
-------------------------------------------------

- [Generating Nginx & PHP Configuration](generators/nginx-php-server-config-generator/README.md)


Usage
-----

- [Installing Docker Stack in your project](docs/80-misc-installing-docker-stack-in-your-project.md)


Building/forking Docker Stack
---------------------------

- [Building Docker Stack Images](docs/71-building-docker-stack-images.md)


FAQ
---

## What is a stack?

> A stack is a collection of services that make up an application in a specific environment. A stack file is a file in YAML format that define one or more services. The YAML reference is documented here.

> A stack is a convenient way to automate the deployment of multiple services that are linked to each other, without the need to define one by one.

> As stack files also define environment variables and related environment-specific configuration, it is recommended to use one stack file per environment (dev, test, prod...).

See [Docker Cloud documentation](https://support.tutum.co/support/solutions/articles/5000569899-stacks)


License
-------

MIT

Acknowledgements
----------------

This repository was co-created with [schmunk42](https://github.com/schmunk42), who is nowadays maintaining docker stack images at [phundament/docker-images](https://github.com/phundament/docker-images).
