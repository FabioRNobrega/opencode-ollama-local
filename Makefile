SHELL := /bin/bash
MODEL ?= qwen3.5:0.8b
CONTEXT ?= 64000
COMPOSE := docker compose

.PHONY: docker-build docker-run docker-down logs ollama-logs opencode-shell opencode-run ollama-chat ollama-pull config-help

## Build the OpenCode image
docker-build:
	$(COMPOSE) build --no-cache

## Start Ollama and the OpenCode container
docker-run:
	OLLAMA_MODEL=$(MODEL) OLLAMA_CONTEXT_LENGTH=$(CONTEXT) $(COMPOSE) up -d
	@echo "OpenCode is ready in Docker with the workspace mounted at /workspace"
	@echo "Please wait the full download from ollama see logs..."

## Stop Ollama and remove the volume with downloaded models
docker-down:
	$(COMPOSE) down -v

## Tail compose logs
logs:
	$(COMPOSE) logs -f

## Tail Ollama logs only
ollama-logs:
	docker logs -f ollama-opencode

## Open a shell inside the OpenCode container
opencode-shell:
	$(COMPOSE) exec opencode bash

## Launch OpenCode inside the container
opencode-run:
	$(COMPOSE) exec opencode bash -lc "cd /workspace && opencode"

## Chat directly with the pulled model inside the container
ollama-chat:
	docker exec -it ollama-opencode ollama run $(MODEL)

## Pull another model without recreating the stack
ollama-pull:
	docker exec -it ollama-opencode ollama pull $(MODEL)

## Print the OpenCode provider values
config-help:
	@printf '%s\n' \
	  'Provider ID: ollama' \
	  'Display name: Ollama (docker)' \
	  'Base URL: http://ollama:11434/v1' \
	  'Model ID: $(MODEL)' \

## Tail logs for API only
api-logs:
	docker compose logs -f api

## Restart API service
api-restart:
	docker compose restart api
