Local Development: First-time set-up
====================================

Open up a terminal window and cd into the root directory of your 12-factor app's repository.

### Step 1 - Setup a local docker host

#### Docker Machine

Install [Docker Machine](https://docs.docker.com/machine/) and create a docker host to use for local development (switch out `virtualbox` for your vm software of choice):

    docker-machine create --driver virtualbox local-docker-host

After each reboot, run:

    docker-machine up local-docker-host

In each new terminal session, run (preferably by adding to ~/.bashrc or similar)

    $(docker-machine env local-docker-host)

Note: This is [currently broken on OS X](https://github.com/docker/machine/issues/721), use [Boot2Docker](http://boot2docker.io/) meanwhile.

#### Boot2Docker

Alternatively, install [Boot2Docker](http://boot2docker.io/)

After each reboot, run:

    boot2docker up

In each new terminal session, run (preferably by adding to ~/.bashrc or similar)

    $(boot2docker shellinit)

## Step 2 - Connect to your local docker host

Needs to be done before running docker commands:

    source .local-docker-host

## Step 3 - Install app dependencies

    docker-compose run shell stack/src/install-deps.sh

## Step 4 - Initialize your local configuration file

Create your local configuration file for sensitive configuration directives:

    cp .env.dist .env

Open it up an make sure that all sensitive directives are correctly entered.

## Step 5 - Run

Fire up your local docker stack:

    docker-compose up

## Step 6 - Initialize the database with a relevant dataset

* Follow the instructions in [Update to the latest changes](21-local-dev-update-to-the-latest-changes.md)

## Step 7 - See your app in action

Find out the ports that your stack is listening on:

    docker-compose ps

Open up relevant urls in the browser to see your app in action.

Hack away!

### Hint 1

Example of how to extract the url to a web container's public http port:

    export DOCKER_HOST_IP=$(echo $DOCKER_HOST | sed 's/tcp:\/\///' | sed 's/:[0-9.]*//')
    export WEB_PORT_80=$(docker-compose port web 80 | sed 's/[0-9.]*://')
    export URL="http://$DOCKER_HOST_IP:$WEB_PORT_80"
    echo $URL

On OS X you can even open the url directly from your terminal:

    open $URL

### Hint 2

When adapting this documentation for your app, you might want to include something more specific like:

* Now your yii apps should be accessible on the following urls locally and you should be able to login with admin/admin:
    * Yii Frontend: [http://192.168.59.103:8001/]()
    * REST API: [http://192.168.59.103:8001/api/]()

### Hint 3

You can echo all available linked environment variables related to running containers:

    docker-compose run info printenv
