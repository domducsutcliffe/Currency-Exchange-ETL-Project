#################################################################################
#
# Makefile to build the project
#
#################################################################################

PROJECT_NAME = volstock-project
REGION = eu-west-2
PYTHON_INTERPRETER = python
WD=$(shell pwd)
PYTHONPATH=${WD}
SHELL := /bin/bash
PROFILE = default
PIP:=pip
ACTIVATE_ENV := source venv/bin/activate

define execute_in_env
	$(ACTIVATE_ENV) && $1
endef

## Create python interpreter environment.
create-environment:
	$(PYTHON_INTERPRETER) -m venv venv

# Execute python related functionalities from within the project's environment
requirements:
	$(call execute_in_env, $(PIP) install requests -t dependencies/)
requirements: create-environment

################################################################################################################
# Set Up
## Install bandit
bandit:
	$(call execute_in_env, $(PIP) install bandit)

## Install safety
safety:
	$(call execute_in_env, $(PIP) install safety)

## Install flake8
flake:
	$(call execute_in_env, $(PIP) install flake8)

pytest:
	$(call execute_in_env, $(PIP) install pytest moto boto3 pg8000)

coverage:
	$(call execute_in_env, $(PIP) install pytest-cov)


## Set up dev requirements (bandit, safety, flake)
dev-setup: bandit safety flake pytest coverage


## Run the unit tests
unit-test:
	$(call execute_in_env, PYTHONPATH=${PYTHONPATH} pytest -vv)

check-coverage:
	$(call execute_in_env, PYTHONPATH=${PYTHONPATH} pytest --cov=src test/)

# Run all checks
run-checks: unit-test check-coverage
