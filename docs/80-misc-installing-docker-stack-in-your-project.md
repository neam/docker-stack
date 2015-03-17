For a local installation, add docker-stack as an extension or submodule to your project and add the local `docker-stack/cli/` directory to PATH.

The cli searches for a docker-stack installation in the following directories in relation to the current working directory:

    ./.docker-stack/
    ~/.docker-stack/
    bower_components/docker-stack/
    node_modules/docker-stack/
    vendor/neam/docker-stack/

