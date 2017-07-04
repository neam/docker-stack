#!/usr/bin/env bash

# directories within containers
chown -R www-data /local-tmp-files
chmod -R g+rw /local-tmp-files

exit 0
