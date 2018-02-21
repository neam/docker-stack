Docker Stack
============

Stacks and images used in production by [Neam Labs](http://neamlabs.com) in order to Develop, Build, Test, Deploy and Maintain PHP+NodeJS-based web applications.

Published as open-source so that they can be used and adapted by other projects, or act as a reference point and inspiration when you set up your own Docker-based stack architecture.

The stacks and images in this repo are verified to work well for both local development and high performance multi-node setups deployed at AWS using [Docker Cloud](https://cloud.docker.com) and [constantly tweaked to be faster and more reliable](./CHANGELOG.md).

Requirements
------------

 * docker 17.12.0-ce (17.12.0-ce+ recommended)
 * docker-compose 1.18.0 (1.18.0+ recommended)
 * git

Why use a Docker-based stack in the first place?
-------------------

Docker stacks allow development teams to weave together web applications written in a any combination of PHP, NodeJS, Java and Python, utilizing Dockerized services (databases, mail servers, task runners, message queues etc).

## For the developer

As a member of a developer team, the Docker-based stack enables you to ditch Vagrant/Puppet/Chef while still maintaining a cross-platform local development workflow similar to the powerful `npm install` + `npm start` combo for javascript-based apps:

    docker-compose run php composer install
    docker-compose up

Thus, in any team or project where multiple developers are involved, less time and hassle is necessary to get the project software running locally, and all team members will be running the same versions of the underlying operating system packages.

## For dev-ops

Maintain a best-practice Docker-based "one-process-per-container" stack and development workflows for your [12-factor web apps](http://12factor.net/).

The stack can then be deployed to any docker host/swarm or orchestrated via [Docker Cloud](https://cloud.docker.com), providing a high degree of dev/prod parity.

Stacks
----------------

- [Debian PHP/Nginx](stacks/neam/debian-php-nginx/stack/README.md)
- [Debian PHP/Nginx + Database (LEMP)](stacks/neam/debian-php-nginx/stack/README.md)
- [DNA Project Base Stack (Based on Debian PHP/Nginx + Database)](stacks/neam/debian-php-nginx.dna-project-base/stack/README.md)

Building Docker Stack Images locally
------------------------------------

- [Building Docker Stack Images](docs/71-building-docker-stack-images.md)

FAQ
---

## What is a stack?

> A stack is a collection of services that make up an application in a specific environment. A stack file is a file in YAML format that define one or more services. The YAML reference is documented here.

> A stack is a convenient way to automate the deployment of multiple services that are linked to each other, without the need to define one by one.

> As stack files also define environment variables and related environment-specific configuration, it is recommended to use one stack file per environment (dev, test, prod...).

License
-------

MIT

Acknowledgements
----------------

This repository was co-created with [schmunk42](https://github.com/schmunk42), who is nowadays maintaining docker stack images at [dmstr](https://github.com/dmstr?utf8=%E2%9C%93&q=docker&type=&language=).
