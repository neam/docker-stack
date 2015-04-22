Local Development: Pulling in changes from team mates
=====================================================

Pull the latest changes recursively:

    stack/src/git-pull-recursive.sh

After pulling the latest changes or restoring to a previous commit, compare your `.env` against `.env.dist` and merge in relevant new configuration options/changes from the latter.

Then, run the following to update your local environment's dependencies:

    stack/src/install-deps.sh

If updates to docker-compose.yml has been made since you last started the docker stack:

    docker-compose up -d

If updates to the data profiles have been made and you have no unsaved data locally:

    stack/shell.sh
    bin/reset-db.sh --force-s3-sync

If updates to the webapps has been made since you last built them and you want to be able to run the webapps with env=dist:

    docker-compose run builder stack/src/build.sh
