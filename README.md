**RECIPE APP API**
---

A recipe app api build in Django.

**Content:**

- [Development environment setup](#development-environment-setup)
  - [Requirements](#requirements)
  - [Environment variables](#environment-variables)
  - [Project setup](#project-setup)
  - [Project execution](#project-execution)
  - [Testing](#testing)
- [Aditional project management instructions](#aditional-project-management-instructions)
  - [Docker](#docker)
  - [Pre-commit](#pre-commit)
  - [Reset local environment](#reset-local-environment)
  - [Postgres configuration](#postgres-configuration)
  - [Django commands](#django-commands)
  - [Pipenv commands](#pipenv-commands)
- [Django project with apps subfolder](#django-project-with-apps-subfolder)

# Development environment setup

## Requirements

The requirements in your computer to run this project are:

- [Docker](https://docs.docker.com/desktop/install/mac-install/)

## Environment variables

Create your `.env` file:

```bash
cp .env.example .env
```

This project is prepared to enable you using git in local and in remote
repositores in the docker container. Be sure you configure the env variables
`GIT_NAME`, `GIT_EMAIL` and `GIT_SSH_PRIVATE_KEY`.

## Project setup

Build the docker stack:

```bash
docker compose build
```

Give execution permission to entrypoint script:

```bash
chmod +x postgres/scripts/create-test-database.sh
```

## Project execution

Create the docker containers and run them:

```bash
docker compose up -d
```

The project will be available in the host machine in the url http://localhost:8000.

## Testing

# Aditional project management instructions

## Docker

Kill project and remove all items related like volumes and containers:

```bash
docker compose down -v --remove-orphans
```

Enter on a container terminal:

```bash
docker compose exec <container_name> bash
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

## Postgres configuration

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

Notes:

This optional environment variable `POSTGRES_USER` is used in conjunction with
`POSTGRES_PASSWORD` to set a user and its password. This variable will create
the specified user with superuser power and a database with the same name. If
it is not specified, then the default user of postgres will be used.

## Django commands

Create a new app:

```bash
python manage.py startapp <APP_NAME>
```

Execute a custom command:

```bash
python manage.py wait_for_db
```

Create migrations:

```bash
python manage.py makemigrations
```

Apply migrations:

```bash
python manage.py migrate
```

Create a superuser:

```bash
python manage.py createsuperuser
```

## Pipenv commands

Install a python dependency:

```bash
pipenv install package_name==package_version
```

Install a python dependency for development:

```bash
pipenv install --dev package_name==package_version
```

Install a python dependency between versions:

```bash
pipenv install 'package_name>=version_min,<version_max'
```

Uninstall a python dependency:

```bash
pipenv uninstall package_name
```

# Django project with apps subfolder

Create `apps` sub folder:

```bash
mkdir apps
touch apps/__init__.py
```

Add app in `apps` sub folder:

```bash
mkdir apps/myapp
python manage.py startapp myapp apps/myapp
```

Update `apps.py` in `apps/myapp` to have the name include `apps.` as shown
below:

```python
class MyappConfig(AppConfig):
    # optional, add default auto field
    default_auto_field = 'django.db.models.BigAutoField'
    # set location of app using sub dir
    name = 'apps.myapp'
    # optional, add name of app
    verbose_name = 'My App Verbose Name'
```

Install app like this:

```python
INSTALLED_APPS = (
    ...
    'apps.myapp',
)
```

Create urls like this:

```python
urlpatterns = patterns('',
  url(r'^myapp', include('apps.myapp.urls')),
  ...
)
```

Make migrations like this:

```bash
makemigrations myapp --pythonpath='apps'
```
