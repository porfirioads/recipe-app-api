**RECIPE APP API**
---

A recipe app api build in Django.

**Content:**

- [Development environment setup](#development-environment-setup)
  - [Requirements](#requirements)
  - [Environment variables](#environment-variables)
  - [Project setup](#project-setup)
  - [Project execution](#project-execution)
  - [Reset local environment](#reset-local-environment)
- [Testing](#testing)
- [Aditional project management commands](#aditional-project-management-commands)
  - [Docker](#docker)
  - [Pipenv](#pipenv)
  - [Pre-commit](#pre-commit)
- [Postgres configuration](#postgres-configuration)

# Development environment setup

## Requirements

The requirements in your computer to run this project are:

- [Docker](https://docs.docker.com/desktop/install/mac-install/)

## Environment variables

Create your `.env` file:

```bash
cp .env.example .env
```

## Project setup

Build the docker stack:

```bash
docker compose build
```

## Project execution

Create the docker containers and run them:

```bash
docker compose up -d
```

Enter in the django project container terminal:

```bash
docker compose exec api bash
```

Inside the container, activate the virtualenv:

```bash
pipenv shell
```

The project is available in the host machine in the url http://localhost:8000.

## Reset local environment

Stop all containers and delete related volumes:

```bash
docker compose down -v --remove-orphans
```

Delete database files:

```bash
sudo rm -r postgres/var/
```

Up services again:

```bash
docker compose up -d
```

Notes:

```POSTGRES_USER```

This optional environment variable is used in conjunction with POSTGRES_PASSWORD to set a user and its password. This variable will create the specified user with superuser power and a database with the same name. If it is not specified, then the default user of postgres will be used.

# Testing

# Aditional project management commands

## Docker

Kill project and remove all items related like volumes and containers:

```bash
docker compose down -v --remove-orphans
```

Enter on a container terminal:

```bash
docker compose exec <container_name> bash
```

## Pipenv

Install a new python dependency:

```bash
pipenv install <package_name==package_version>
```

Install a new python dependency for development:

```bash
pipenv install --dev <package_name==package_version>
```

Uninstall a python dependency:

```bash
pipenv install <package_name>
```

## Pre-commit

Create a pre-commit basic configuration file:

```bash
pre-commit sample-config > .pre-commit-config.yaml
```

Install pre-commit hooks:

```bash
pre-commit install
```
# Postgres configuration

Create databases:

```sql
CREATE DATABASE recipe_app_api;
CREATE DATABASE recipe_app_api_test;
```

Create user who will manage the databases:

```sql
CREATE USER recipe_app_api;
ALTER USER recipe_app_api WITH PASSWORD <THE_PASSWORD>;
```

Give permissions to the created user:

```sql
GRANT ALL PRIVILEGES ON DATABASE recipe_app_api TO recipe_app_api;
GRANT ALL PRIVILEGES ON DATABASE recipe_app_api_test TO recipe_app_api;
```
