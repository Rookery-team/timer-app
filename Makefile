#!make
include .env

SHELL = /bin/bash

ifndef VERBOSE
.SILENT:
endif

.PHONY: help
help:
	@echo "Utilisation : make [COMMAND]"
	@make project
	@make repository
	@make docker
	@make git

.DEFAULT_GOAL := help

# -------------------------
# Une affaire de Docker

.PHONY: docker
docker: ## Affiche les commandes utilisant Docker
	@echo "Commandes utilisant Docker :"
	@grep -E '^(pull-images|serve|down|build)+:.*?## .*$$' 'Makefile' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: pull-images
pull-images: ## Extrait toutes les images Docker utilisées dans docker-compose.yml
	@echo "Extraction des images Docker..."
	@docker-compose pull

.PHONY: serve
serve: ## Met en service l'ensemble de l'application
	@echo "Lancement des images Docker..."
	@docker-compose up -d
	@echo "L'application est dorénavant accessible à l'adresse http://localhost:8000 !"

.PHONY: down
down: ## Stoppe l'application et supprime tous les containers, réseaux et volumes partagés
	@echo "Arrêt des images Docker..."
	@docker-compose down -v
	@echo "Arrêt de l'application !"

.PHONY: build
build: ## Extrait toutes les images Docker utilisées dans docker-compose.yml et les construit
	@echo "Construction des images Docker (avec extraction)..."
	@docker-compose build --pull
	@echo "Images Docker construites !"

# -------------------------
# Une affaire de Git

.PHONY: git
git: ## Affiche les commandes utilisant Git
	@echo "Commandes utilisant Git :"
	@grep -E '^(clone(-[a-zA-Z0-9\-]+)?)|(pull(-[a-zA-Z0-9\-]+)?)+:.*?## .*$$' 'Makefile' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clone
clone: clone-timer-back clone-timer-ui ## Clone les répertoires git du projet
	@chown -R ${ENV_USER}:${ENV_USER_GROUP} .

.PHONY: clone-timer-back
clone-timer-back: ## Clone le répertoire git `timer-back`
	@echo "Clonage du répertoire 'timer-back'..."
	@if [ -d "timer-back" ]; then \
		echo "Répertoire 'timer-back déjà existant !"; \
		make clean-timer-back; \
	fi;
	@git clone https://${GIT_USER}:${GIT_PASSWORD}@github.com/ipssi-timer/timer-back.git timer-back
	@echo "Répertoire 'timer-back cloné !"

.PHONY: clone-timer-ui
clone-timer-ui: ## Clone le répertoire git `timer-ui`
	@echo "Clonage du répertoire 'timer-ui'..."
	@if [ -d "timer-ui" ]; then \
		echo "Répertoire 'timer-ui' déjà existant !"; \
		make clean-timer-ui; \
	fi;
	@git clone https://${GIT_USER}:${GIT_PASSWORD}@github.com/ipssi-timer/timer-front.git timer-ui
	@echo "Répertoire 'timer-ui' cloné !"

.PHONY: pull
pull: pull-timer-back pull-timer-ui ## Met à jour les répertoires `timer-back` et `timer-ui`

.PHONY: pull-timer-back
pull-timer-back: ## Met à jour le répertoire git `timer-back`
	@echo "Mise à jour du répertoire 'timer-back'..."
	@cd timer-back
	@git pull origin master
	@echo "Répertoire 'timer-back' mis à jour !"

.PHONY: pull-timer-ui
pull-timer-ui: ## Met à jour le répertoire git `timer-ui`
	@echo "Mise à jour du répertoire 'timer-ui'..."
	@cd timer-ui
	@git pull origin master
	@echo "Répertoire 'timer-ui' mis à jour !"

# -------------------------
# Une affaire de répertoire

.PHONY: repository
repository: ## Affiche les commandes manipulant le répertoire
	@echo "Commandes manipulant le répertoire :"
	@grep -E '^(clean(-[a-zA-Z0-9\-]+)?)+:.*?## .*$$' 'Makefile' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: clean-timer-back clean-timer-ui ## Supprime les répertoires `timer-back` et `timer-ui`

.PHONY: clean-timer-back
clean-timer-back: ## Supprime le répertoire `timer-back`
	@echo "Suppression du répertoire 'timer-back'..."
	@rm -rf timer-back
	@echo "Répertoire 'timer-back' supprimé !"

.PHONY: clean-timer-ui
clean-timer-ui: ## Supprime le répertoire `timer-ui`
	@echo "Suppression du répertoire 'timer-ui'..."
	@rm -rf timer-ui
	@echo "Répertoire 'timer-ui' supprimé !"

# -------------------------
# Une affaire de projet

.PHONY: project
project: ## Affiche les commandes manipulant le projet
	@echo "Commandes manipulant le projet :"
	@grep -E '^(install|run|dependencies)+:.*?## .*$$' 'Makefile' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: ## Installe l'application
	@echo "Installation de l'application..."
	@echo "Clonage des répertoires git de l'application..."
	@make clone
	@echo "Clonage de la configuration vers 'timer-back'..."
	@cp -f .env timer-back/.env
	@echo "Construction de l'application..."
	@make build
	@echo "Installation des dépendences..."
	@make dependencies
	@echo "Installation terminée !"

.PHONY: run
run: ## Construit l'ensemble du projet (Au clone jusqu'à la mise en service)
	@make install
	@echo "Mise en service de l'application..."
	@make serve

.PHONY: dependencies
dependencies: timer-back/vendor timer-back/node_modules timer-ui/node_modules ## Construit les dépendences du projet

# -------------------------
# Prépare les dépendences de l'application

timer-back/composer.lock: timer-back/composer.json
	@docker-compose run -e COMPOSER_MEMORY_LIMIT=-1 --rm timer-back sh -c "cd /var/www/timer-back && composer install --prefer-dist --optimize-autoloader --no-interaction"

timer-back/vendor: timer-back/composer.lock
	@docker-compose run -e COMPOSER_MEMORY_LIMIT=-1 --rm timer-back sh -c "cd /var/www/timer-back && composer install --prefer-dist --optimize-autoloader --no-interaction"

timer-back/yarn.lock: timer-back/package.json
	@docker-compose run --rm timer-back-node sh -c "cd /var/www/timer-back && yarn install && yarn encore dev"

timer-back/node_modules: timer-back/yarn.lock
	@docker-compose run --rm timer-back sh -c "cd /var/www/timer-back && yarn install --non-interactive --frozen-lockfile --check-files && yarn encore dev"

timer-ui/yarn.lock: timer-ui/package.json
	@docker-compose run --rm timer-back sh -c "cd /var/www/timer-ui && yarn install --non-interactive"

timer-ui/node_modules: timer-ui/yarn.lock
	@docker-compose run --rm timer-back sh -c "cd /var/www/timer-ui && yarn install --non-interactive --frozen-lockfile --check-files"
