.PHONY: bake
bake: ## bake without inputs and overwrite if exists.
	@uv run cookiecutter --no-input . --overwrite-if-exists

.PHONY: bake-src
bake-src: ## bake without inputs and overwrite if exists.
	@uv run cookiecutter --no-input . --overwrite-if-exists layout="src"

.PHONY: bake-with-inputs
bake-with-inputs: ## bake with inputs and overwrite if exists.
	@uv run cookiecutter . --overwrite-if-exists

.PHONY: bake-and-test-deploy
bake-and-test-deploy: ## For quick publishing to lamablueprint-example to test GH Actions
	@rm -rf lamablueprint-example || true
	@uv run cookiecutter --no-input . --overwrite-if-exists \
		author="LAMA lab" \
		email="lamalab@lamalab.org" \
		author_github_handle=lamalab-org \
		project_name=lamablueprint-example \
		project_slug=lamablueprint_example
	@cd lamablueprint-example; uv sync && \
		git init -b main && \
		git add . && \
		uv run pre-commit install && \
		uv run pre-commit run -a || true && \
		git add . && \
		uv run pre-commit run -a || true && \
		git add . && \
		git commit -m "init commit" && \
		git remote add origin git@github.com:lamalab-org/lamablueprint-example.git && \
		git push -f origin main


.PHONY: install
install: ## Install the virtual environment
	@echo "🚀 Creating virtual environment"
	@uv sync

.PHONY: check
check: ## Run code quality tools.
	@echo "🚀 Checking lock file consistency with 'pyproject.toml'"
	@uv lock --locked
	@echo "🚀 Linting code: Running pre-commit"
	@uv run pre-commit run -a
	@echo "🚀 Static type checking: Running mypy"
	@uv run mypy
	@echo "🚀 Checking for obsolete dependencies: Running deptry"
	@uv run deptry {% if cookiecutter.layout == "src" %}"src"{% else %}.{% endif %}

.PHONY: test
test: ## Test the code with pytest.
    @echo "🚀 Testing code: Running pytest"
    @uv run python -m pytest tests

.PHONY: build
build: clean-build ## Build wheel file
	@echo "🚀 Creating wheel file"
	@uvx --from build pyproject-build --installer uv

.PHONY: clean-build
clean-build: ## Clean build artifacts
	@echo "🚀 Removing build artifacts"
	@uv run python -c "import shutil; import os; shutil.rmtree('dist') if os.path.exists('dist') else None"

.PHONY: publish
publish: ## Publish a release to PyPI.
	@echo "🚀 Publishing: Dry run."
	@uvx --from build pyproject-build --installer uv
	@echo "🚀 Publishing."
	@uvx twine upload --repository-url https://upload.pypi.org/legacy/ dist/*

.PHONY: build-and-publish
build-and-publish: build publish ## Build and publish.

.PHONY: help
help:
	@uv run python -c "import re; \
	[[print(f'\033[36m{m[0]:<20}\033[0m {m[1]}') for m in re.findall(r'^([a-zA-Z_-]+):.*?## (.*)$$', open(makefile).read(), re.M)] for makefile in ('$(MAKEFILE_LIST)').strip().split()]"

.DEFAULT_GOAL := help
