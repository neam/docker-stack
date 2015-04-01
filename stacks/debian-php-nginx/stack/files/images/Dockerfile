# Project files data volume container docker image
# --------------------------------
# docker build -t neam/files-empty-data-container .
# docker push neam/files-empty-data-container

FROM debian:jessie

# Add empty /files directory as base of volume mount point
RUN mkdir /files

# Use a valid cmd that immediately exits for this data only container
CMD /bin/echo 'The data volume container with an empty /files directory code will now exit, leaving the /files directory available for all other containers in the stack'
