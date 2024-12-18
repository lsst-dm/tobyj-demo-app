.PHONY: help
help:
	@echo "Make targets for tobyj-demo-app"
	@echo "make init - Set up dev environment"
	@echo "make run - Start a local development instance"
	@echo "make update - Update pinned dependencies and run make init"
	@echo "make update-deps - Update pinned dependencies"

.venv:
	uv venv

.PHONY: init
init:
	uv pip install -r requirements/main.txt -r requirements/dev.txt \
	    -r requirements/tox.txt
	uv pip install --editable .
	rm -rf .tox
	uv pip install --upgrade pre-commit
	uv run pre-commit install

.PHONY: run
run:
	tox run -e run

.PHONY: update
update: update-deps init

.PHONY: update-deps
update-deps: .venv
	uv pip install --upgrade pre-commit
	uv run pre-commit autoupdate
	uv pip compile --upgrade --universal --generate-hashes		\
	    --output-file requirements/main.txt requirements/main.in
	uv pip compile --upgrade --universal --generate-hashes		\
	    --output-file requirements/dev.txt requirements/dev.in
	uv pip compile --upgrade --universal --generate-hashes		\
	    --output-file requirements/tox.txt requirements/tox.in
