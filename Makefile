.DEFAULT_GOAL := default_target
.PHONY: default_target test clean setup create-venv setup-dev setup-os git-up code-convention test run all

NPROC := `nproc --all`
PYTEST := py.test -n$(NPROC)
PIP := pip install -r

PROJECT_NAME := postcode-uk
PYTHON_VERSION := 3.7.3
VENV_NAME := $(PROJECT_NAME)-$(PYTHON_VERSION)

# Environment setup
.pip:
	pip install pip --upgrade

setup: .pip
	$(PIP) requirements.txt

setup-dev: .pip
	$(PIP) requirements/local.txt

setup-production: .pip
	$(PIP) requirements/production.txt

.clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

.clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

.clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr reports/
	rm -fr .pytest_cache/

clean: .clean-build .clean-pyc .clean-test ## remove all build, test, coverage and Python artifacts

.create-venv:
	pyenv install -s $(PYTHON_VERSION)
	pyenv uninstall -f $(VENV_NAME)
	pyenv virtualenv $(PYTHON_VERSION) $(VENV_NAME)
	pyenv local $(VENV_NAME)

create-venv: .create-venv setup-dev

# Repository
git-up:
	git pull
	git fetch -p --all

code-convention:
	flake8
	pycodestyle

# Tests
test:
	$(PYTEST) --cov-report=term-missing  --cov-report=html --cov=.

all: create-venv git-up setup-dev default_target

default_target: clean code-convention test
