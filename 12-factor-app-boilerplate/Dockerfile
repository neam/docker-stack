# Project source code data volume container docker image
# --------------------------------

FROM neam/docker-php-toolkit-app-source-code-container-base:latest

# Add composer github token for faster downloads
COPY composer.github.token composer.github.token
RUN /usr/local/bin/composer config -g github-oauth.github.com "$(cat composer.github.token)" --no-interaction

# Run project-specific installation of dependencies (put the ones most likely to change at the bottom in order to re-use as many image layers as possible)

WORKDIR /app/
COPY composer.lock /app/composer.lock
COPY composer.json /app/composer.json
RUN /usr/local/bin/composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction --ignore-platform-reqs

WORKDIR /app/dna/
COPY dna/composer.lock /app/dna/composer.lock
COPY dna/composer.json /app/dna/composer.json
RUN /usr/local/bin/composer install --prefer-dist --no-dev --optimize-autoloader --no-interaction --ignore-platform-reqs

WORKDIR /app/

# Add source code to volume mount point
COPY . /app

# Env var with path to application directory
ENV APP_DIR /app

# Use a valid cmd that immediately exits for this data only container
CMD ["true"]
