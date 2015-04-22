# Project nginx docker image with source code
# --------------------------------

FROM nginx:1.7

# Add source code to /src
COPY . /app
