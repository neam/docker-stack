Docker Stack
============

> **Active development disclaimer**: Code is still being moved around and being updated while preparing for a stable release. That said, the stacks stemming from this project have been verified to work well for both local development and high performance multi-node setups deployed at AWS using [the container platform service Tutum](https://tutum.io)

This project is dedicated to maintain a couple of best-practice Docker-based stacks and related images that can be used and adapted by your projects, or act as a reference point and inspiration when you set up your own Docker-based stack architecture.


Develop, Build, Test, Deploy and Maintain your 12-factor web app using Docker
-----------------------------------------------------------------------------

Uses [Docker Compose, Docker Machine and Docker](http://blog.docker.com/2014/12/announcing-docker-machine-swarm-and-compose-for-orchestrating-distributed-apps/) to maintain a base-practice Docker-based "one-process-per-container" stack and development workflows for your [12-factor web apps](http://12factor.net/).

Enables easy app-specific orchestration of dockerized services (databases, mail servers, task runners, message queues etc).


Requirements
------------

 * docker 1.8.3+
 * docker-compose 1.4.2+
 * git


Why use a Docker-based stack in the first place?
-------------------

As a member of a developer team, the Docker-based stack enables you to ditch Vagrant/Puppet/Chef while still maintaining a cross-platform local development workflow similar to the powerful `npm install` + `grunt serve` combo for javascript-based apps:

    docker-compose run worker composer install
    docker-compose up

Thus, in any team or project where multiple developers are involved, less time and hassle is necessary to get the project software running locally.

The stack can then be deployed to any docker host/swarm or orchestrated via [the container platform service Tutum](https://tutum.com), providing a high degree of dev/prod parity.


Why `docker-stack`?
-------------------

Setting up, configuring and maintaining a Docker-based stack takes time, and docker-stack makes it possible to re-use existing stack configurations which empowers [the 12-factor web app](http://12factor.net/). 

Care has been taken to make all vital configuration files visible and easy customizable, so that it is straightforward to tweak, adjust and debug configuration issues.


Available Stacks
----------------

### Publisher: neam

These stacks and underlying concepts are used in production by [Neam Labs](http://neamlabs.com) and are [constantly tweaked to be faster and more reliable](./CHANGELOG.md).

- [Hello World](stacks/neam/hello-world/README.md)
- [Debian PHP/Nginx](stacks/neam/debian-php-nginx/stack/README.md)
- [Debian PHP/Nginx + Database](stacks/neam/debian-php-nginx/stack/README.md)
- [DNA Project Base Stack (Based on Debian PHP/Nginx)](stacks/neam/debian-php-nginx.dna-project-base/stack/README.md)
- [Tutum HAProxy Virtual Host Proof-of-concept](stacks/neam/text-to-flowchart-generators-haproxy-vhost-example/README.md)

### Publisher: schmunk42

These stacks and underlying concepts are used in production by [Herzog Kommunikation - The Application Factory](http://herzogkommunikation.de/)

- [PHP/Nginx](stacks/schmunk42/php-nginx/README.md)
- [PHP/Nginx Vanilla](stacks/schmunk42/php-nginx-vanilla/README.md)
- [ELK](stacks/schmunk42/elk/README.md)
- [Phundament](stacks/schmunk42/phundament/)
- [Docker Registry Mirror](stacks/schmunk42/registry-mirror/)
- [Yii 2.0 Framework](stacks/schmunk42/yii2/README.md)


Command-line tools
------------------

There are three main ways to interact with a Docker-based once installed in your project:
 * `docker-compose` 
 * `docker-stack` CLI 
 * `doma` 

Read more about them below.

### `docker-compose`

Docker Compose is the heart of Docker Stack. Once a stack is installed in your project folder (and thus a docker-compose.yml file is present), docker-compose can be used "as usual".

### `docker-stack` CLI

A wrapper around `docker-compose` that allows to list, select and interact with third-party stacks without copying the stack files to the project folder. 

- [Docker Stack CLI Introduction](docs/10-docker-stack-cli.md)

Instructions for using/adopting docker-based stacks for your 12-factor web app:

- [Adopting a Docker stack](docs/10-stacks-adopting-a-docker-stack.md)

### `doma`

DOcker and MAkefile combined for easy stack/application control.

Requirements:
 * `make`

Control your stacks and applications with `Makefile` templates for `docker`, `docker-composer`, `tutum`, `aws-s3` or `mysql`.

For full documentation see [GitHub](https://github.com/schmunk42/doma) Repository.


Configuration Generators included in Docker Stack
-------------------------------------------------

- [Generating Nginx & PHP Configuration](generators/nginx-php-server-config-generator/README.md)


Misc
----

- [Installing Docker Stack in your project](docs/80-misc-installing-docker-stack-in-your-project.md)


Development of Docker Stack
---------------------------

- [Building Docker Stack Images](docs/71-building-docker-stack-images.md)


FAQ
---

## What is a stack?

> A stack is a collection of services that make up an application in a specific environment. A stack file is a file in YAML format that define one or more services. The YAML reference is documented here.

> A stack is a convenient way to automate the deployment of multiple services that are linked to each other, without the need to define one by one.

> As stack files also define environment variables and related environment-specific configuration, it is recommended to use one stack file per environment (dev, test, prod...).

See [tutum documentation](https://support.tutum.co/support/solutions/articles/5000569899-stacks)


License
-------

MIT
