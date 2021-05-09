ifeq ($(shell uname),Linux)
	OS=linux
else
	OS=mac
endif

.EXPORT_ALL_VARIABLES:
DOT_PATH:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONY: all
all: init deploy post_deploy ## Run all

.PHONY: init
init: ## Install apps and git clone
	sh bootstrap/$(OS)-init.sh
	sh bootstrap/unix-init.sh

.PHONY: deploy
deploy: ## Symlink dotfiles
	sh bootstrap/$(OS)-deploy.sh
	sh bootstrap/unix-deploy.sh

.PHONY: post_deploy
post_deploy: ## Process after init and deploy
	sh bootstrap/$(OS)-post-deploy.sh
	sh bootstrap/unix-post-deploy.sh

.PHONY: clean
clean: ## Remove created directories and symlinks except for apps via package management
	sh bootstrap/$(OS)-clean.sh
	sh bootstrap/unix-clean.sh

.PHONY: help
help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
