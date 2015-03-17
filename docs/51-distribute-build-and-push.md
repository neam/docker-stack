Distribute - Build and push
===========================

Build image that ships the source code into deployment:

    docker build -f .src.builder.Dockerfile -t ${APP_ID}:${BRANCH} .

Deploy the production stack to verify that it works:

    docker-compose -f stack/deploy.yml up -d

## Push to the docker registry

Make sure you have signed up on [https://registry.hub.docker.com]() and have been invited to access any private repositories of docker images that the app depends on if any.

Login to the docker registry (unless you have already done so previously):

    docker login

Push your built images

    docker push ${APP_ID}:${BRANCH}

## Build from a clean git clone

### Manually

SSH into any docker host and clone your app source code:

    git clone https://example.com/app.git
    cd project

Then run the commands above to build and push.

This is a recommended practice to ensure consistent builds that are not polluted with any developer's uncommitted/unpushed modifications.

It is also a convenient way of not being limited of your current connection or computer speed. Building and pushing using a server may drastically reduce your build/push times.

### Automatically

Use Docker registry's automated build service.
