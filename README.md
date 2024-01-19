# recipe-app-api

- [recipe-app-api](#recipe-app-api)
- [Comands](#comands)


Recipe API project.

# Comands

Lint code:

```bash
docker compose run --rm app sh -c "flake8"
```

Create django project:

```
docker compose run --rm app sh -c "django-admin startproject app ."
```

Test project:

```
docker compose run --rm app sh -c "python manage.py test"
```
