Stacks - PHP/Nginx/Memcache - DNA Project Base
===================================

## Installation

Clone/download a copy of this repository and copy the boilerplate files to your 12-factor app base dir.

    cd my-app
    docker-stack install debian-php-nginx.memcache
    docker-stack install debian-php-nginx.memcache.dna-project-base

## Local Extras

The local stack include optional containers that emulate upstream services outside of your control. Simply comment them out if you do not need them.

### Explanation of the extra local containers

* `db` - Runs a local MariaDB docker container with persistent data
* `mailcatcher` - Runs a mailcatcher SMTP server
* `proxy` - Runs a nginx reverse proxy using the configuration found in `project root``/../proxy`.

### Corresponding services in production

* `db` - A cloud database service such as Amazon RDS, Rackspace Cloud DB, ClearDB etc
* `mailcatcher` - An SMTP service such as Gmail, Amazon Simple Mail Service, Foo etc
* `proxy` - A reverse proxy or other routing layer on the server(s) that your public DNS is connected to

### Using memcache

TODO: Add instructions

