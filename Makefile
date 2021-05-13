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
	bash bootstrap/$(OS)-init.sh
	bash bootstrap/unix-init.sh

.PHONY: deploy
deploy: ## Symlink dotfiles
	bash bootstrap/$(OS)-deploy.sh
	bash bootstrap/unix-deploy.sh

.PHONY: post_deploy
post_deploy: ## Process after init and deploy
	bash bootstrap/$(OS)-post-deploy.sh
	bash bootstrap/unix-post-deploy.sh

.PHONY: clean
clean: ## Remove created directories and symlinks except for apps via package management
	bash bootstrap/$(OS)-clean.sh
	bash bootstrap/unix-clean.sh

.PHONY: help
help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
