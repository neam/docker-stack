Docker Stack - Develop, Build, Test, Deploy and Maintain your 12-factor web app using Docker
=========================================================================================

Use [Docker Compose, Docker Machine and Docker 1.5.0+](http://blog.docker.com/2014/12/announcing-docker-machine-swarm-and-compose-for-orchestrating-distributed-apps/) to maintain a Docker-based "one-process-per-container" stack and development workflows for your 12-factor web apps.

The stack can be deployed to any docker host/swarm or [the container platform service Tutum](https://tutum.io).

As a member of a developer team, the stack enables you to ditch Vagrant/Puppet/Chef while still maintaining a cross-platform local development workflow similar to the powerful `npm install` + `grunt serve` combo for javascript-based apps:

    docker-compose run shell composer install
    docker-compose up

Includes sample documentation on how to use the stack for a wide range of web app development workflows, ranging from setting up the project for new developers to solving production software bugs.

Stacks
------

This section includes instructions for including a docker-based stack in your 12-factor web app repository.

- [Overview](10-stacks-overview.md)
- [PHP-FPM/Nginx/Memcache](11-stacks-php-nginx-memcache.md)

Develop
-------

This section includes sample documentation for developers to hack on a project that has adopted a docker-based stack.

- [Introduction](20-local-dev-introduction.md)
- [First-time set-up](21-local-dev-first-time-set-up.md)
- [Pulling in changes](21-local-dev-pulling-in-changes.md)
- [Working with secrets](22-local-dev-working-with-secrets.md)
- [Working with database data](23-local-dev-working-with-database-data.md)
- [Working with tests](24-local-dev-working-with-tests.md)
- [Code generation](25-local-dev-code-generation.md)

Deploy
------

This section includes sample documentation on how to package and deploy your 12-factor web app for deployment elsewhere.

- [Build](51-deploy-build-and-push.md)
- [Deploy](52-distribution-deploy.md)

Release Management
------------------

This section includes sample documentation on how to update and troubleshoot your 12-factor web app in production.

- [Production release routines](60-release-routines.md)
- [Live troubleshooting](61-live-troubleshooting.md)
- [If something is wrong with the latest release](62-if-something-is-wrong-with-the-latest-release.md)
- [Staging new features](63-staging-new-features.md)

License
-------

MIT