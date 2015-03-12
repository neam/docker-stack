Local Development: Update to the latest changes
===============================================

After pulling the latest changes or restoring to a previous commit, compare your `.env` against `.env.dist` and merge in relevant new configuration options/changes from the latter.

Install the app's current dependencies:

    docker-compose run builder stack/src/install-deps.sh

In case your stack is running, don't forget to restart it to use the latest configuration.

Also, you might need to follow the instructions in "Reset the database" with a force sync from S3 in [Working with data](23-local-dev-working-with-data.md) in case the references to versioned datasets have been updated.
