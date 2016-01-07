# doma environment
# ================

REGISTRY_HOST ?= registry.example.com
REGISTRY_USER ?= registry
PROJECT_REGISTRY ?= $(REGISTRY_HOST)/project

COMPOSE_PROJECT_NAME 	?= mcgx
BUILDER_SERVICE_SUFFIX 	?= src
COMPOSE_FILE			?= docker-compose.yml

APP_NAMES    	?=   api         	shop
APP_FOLDERS		?=   api.mcgx.de 	shop.mcgx.de

WEB_SERVICE_SUFFIX ?= nginx

# Add this Makefile's targets to help
# -----------------------------------

HELP_FUN = \
		%help; \
		while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([\w-]+)\s*:.*\#\#(?:@([\w-]+))?\s(.*)$$/ }; \
		print "\nusage: make [config] [select] [target]\n\n"; \
	for (keys %help) { \
		print "$$_:\n"; \
		for (@{$$help{$$_}}) { \
			$$sep = "." x (25 - length $$_->[0]); \
			print "  $$_->[0]$$sep$$_->[1]\n"; \
		} \
		print "\n"; }

.PHONY: help
help:
	@$(MAKE) -C $(firstword $(APP_FOLDERS)) help
	#
	# Application configuration & selection targets
	#
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

# Local development config targets
# --------------------------------

.PHONY: TEST
TEST:		##@config configure application for local TESTING
	$(eval BUILDER_SERVICE_SUFFIX := buildertmp)
	$(eval COMPOSE_FILE := docker-compose-test-local.yml)
	$(eval COMPOSE_PROJECT_NAME := testmcgx)
	@#

.PHONY: CI
CI:		##@config configure application for INTEGRATION testing
	$(eval BUILDER_SERVICE_SUFFIX := builder)
	$(eval COMPOSE_FILE := docker-compose-ci-gitlab.yml)
	@#

.PHONY: STAGING
STAGING:		##@config configure application for local STAGING
	$(eval BUILDER_SERVICE_SUFFIX := src)
	$(eval COMPOSE_FILE := docker-compose-staging-mcgx.yml)
	$(eval COMPOSE_PROJECT_NAME := stagingmcgx)
	@#

# App selection targets
# ---------------------

.PHONY: API
API:		##@select select API application only
	$(eval APP_NAMES := api)
	$(eval APP_FOLDERS := api.mcgx.de)
	$(eval cwd := api.mcgx.de)
	@#

.PHONY: SHOP
SHOP:		##@select select SHOP application only
	$(eval APP_NAMES := shop)
	$(eval APP_FOLDERS := shop.mcgx.de)
	$(eval cwd := shop.mcgx.de)
	@#

# Catch non app-specific targets
# ------------------------------

.PHONY: build

.PHONY: NON-INTERACTIVE
NON-INTERACTIVE:
	$(eval DOMA_ENVIRONMENT := non-interactive)
	@#

ADMIN-LESS:
	$(eval APP_ASSETS_SRC_LESS	?= ./modules/admin/assets/web/crud.less)
	$(eval APP_ASSETS_DEST_CSS 	?= ./modules/admin/assets/web/crud.css)


# Catch and propagate inherited targets
# -------------------------------------

.EXPORT_ALL_VARIABLES:

all: app-pull app-install app-setup app-build-tests app-build app-update-version app-up app-open

test-up: app-up app-setup import-test-data app-open

doma%:
	@$(MAKE) -f $(DOMA_DIR)/base/Makefile $@

docker%:
	@$(MAKE) -f $(DOMA_DIR)/docker/Makefile $@

.DEFAULT:
	#
	# Configured applications: $(APP_NAMES)
	#              in folders: $(APP_FOLDERS)
	#
	@for folder in $(APP_FOLDERS); do \
		echo \# --------------------------------------------- ; \
		echo \# ; \
		echo \# Running \'make $@\' in folder \'$$folder\' ; \
		echo \# ; \
		$(MAKE) -C $$folder COMPOSE_FILE=../$(COMPOSE_FILE) $@ ; \
	done


# Local development
# -----------------

crud:
	docker-compose run  --rm apicli sh /app/build/crud.sh

import-test-data:
	docker-compose run  --rm apicli ./yii migrate --migrationLookup=@app/migrations/test2 --interactive=0

import-api:
	docker-compose run  --rm apicli ./yii test-data-api/import $(opts)

worker:
	docker-compose run -d apicli ./yii resque/work

host-info:
	docker-compose run shopfpm curl http://172.17.0.52:80/v1/
	docker-compose run shopfpm cat /etc/hosts
	docker-compose run shopfpm env

reset: docker-kill docker-rm

dev-bump: docker-compose-stacks update-version


# Support for custom project/asset directory structure
ci-setup-assets:
	rm -rf shop.mcgx.de/config/assets-gen
	mkdir -p shop.mcgx.de/config/assets-gen/
	touch shop.mcgx.de/config/assets-gen/dev.php shop.mcgx.de/config/assets-gen/prod.php
