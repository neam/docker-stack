# Project source code data volume container docker image
# --------------------------------

FROM debian:jessie

WORKDIR /app/

# Add source code to /src
COPY . /src

# On runtime - in order to update the data volume with source code - copy source code to volume mount point and then run a valid cmd that immediately exits
CMD rm -rf /app/* && cp -r /src/* /app/ && /bin/echo 'The data volume container with project source code will now exit, leaving the /app directory available for all other containers in the stack'
