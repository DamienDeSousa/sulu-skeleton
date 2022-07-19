MAKE=make

SHELL := /bin/bash

CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)
CURRENT_PWD := $(shell pwd)

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

fix-permission: ## fix permission on project files
	sudo chown ${CURRENT_UID}:${CURRENT_GID} -R .
	docker-compose exec server chown www-data:www-data -R public/uploads

npm-install: ## npm install
	docker-compose exec server npm install

npm-build: ## npm run build
	docker-compose exec server npm run build

npm-init:
	docker-compose exec server npm init