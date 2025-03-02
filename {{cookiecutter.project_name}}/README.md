# {{cookiecutter.project_name}}

[![Build status](https://img.shields.io/github/actions/workflow/status/{{cookiecutter.author_github_handle}}/{{cookiecutter.project_name}}/main.yml?branch=main)](https://github.com/{{cookiecutter.author_github_handle}}/{{cookiecutter.project_name}}/actions/workflows/main.yml?query=branch%3Amain)
[![Supported Python versions](https://img.shields.io/badge/python-3.9_%7C_3.10_%7C_3.11_%7C_3.12_%7C_3.13-blue?labelColor=grey&color=blue)](https://github.com/{{cookiecutter.author_github_handle}}/{{cookiecutter.project_name}}/blob/main/pyproject.toml)
[![Docs](https://img.shields.io/badge/docs-gh--pages-blue)](https://{{cookiecutter.author_github_handle}}.github.io/{{cookiecutter.project_name}}/)
[![License](https://img.shields.io/github/license/{{cookiecutter.author_github_handle}}/{{cookiecutter.project_name}})](https://img.shields.io/github/license/{{cookiecutter.author_github_handle}}/{{cookiecutter.project_name}})

{{cookiecutter.project_description}}

- **Github repository**: <https://github.com/{{cookiecutter.author_github_handle}}/{{cookiecutter.project_name}}/>
- **Documentation** <https://{{cookiecutter.author_github_handle}}.github.io/{{cookiecutter.project_name}}/>

## Getting started with your project

### 1. Create a New Repository

First, create a repository on GitHub with the same name as this project, and then run the following commands:

```bash
git init -b main
git add .
git commit -m "init commit"
git remote add origin git@github.com:{{cookiecutter.author_github_handle}}/{{cookiecutter.project_name}}.git
git push -u origin main
```

### 2. Set Up Your Development Environment

Then, install the environment and the pre-commit hooks with

```bash
make install
```

This will also generate your `uv.lock` file

### 3. Run the pre-commit hooks

Initially, the CI/CD pipeline might be failing due to formatting issues. To resolve those run:

```bash
uv run pre-commit run -a
```

### 4. Commit the changes

Lastly, commit the changes made by the two steps above to your repository.

```bash
git add .
git commit -m 'Fix formatting issues'
git push origin main
```

You are now ready to start development on your project!

Repository initiated with [lamalab-org/cookiecutter-uv](https://github.com/lamalab-org/cookiecutter-uv).
