# Changelog

## 6.8.1 (Unreleased)

- ...

## 6.8.0 (2024-04-03)

- Compatible with Taiga 6.8.0

## 6.7.2 (2024-02-12)

- Add some missed settings (email service and instance domain) to docker-compose-inits.yml

## 6.7.1 (2023-08-08)

- Fixes high CPU peaks for rabbitmq services

## 6.7.0 (2023-06-12)

- Compatible with Taiga 6.7.0

## 6.6.0 (2023-03-06)

- New .env based configuration docker
- Control services startup based on healthchecks
- Thanks to @tibroc for adding hostnames to rabbitmq services
- Thanks to @ralfyang for updating shell scripts to use latest docker version

## 6.5.0 (2022-01-24)

- Compatible with Taiga 6.5.0

## 6.4.0 (2021-09-06)

- Serve Taiga in subpath

## 6.3.0 (2021-08-10)

- Temporary fix specifying latest valid image of RabbitMQ (issue #tg-4700)

## 6.2.2 (2021-07-15)

- Compatible with Taiga 6.2.2

## 6.2.1 (2021-06-22)

- Compatible with Taiga 6.2.1

## 6.2.0 (2021-06-09)

- Compatible with Taiga 6.2.0

## 6.1.1 (2021-05-18)

- Compatible with Taiga 6.1.1

## 6.1.0 (2021-05-04)

- Update github templates

## 6.0.4 (2021-04-06)

- Add named volumes for rabbit services
- Improve docker configuration with `POSTGRES_PORT`.

## 6.0.3 (2021-02-22)

- Improve docker configuration with `EVENTS_PUSH_BACKEND_URL` and `CELERY_BROKER_URL` variables. Thanks to @ginuerzh.
- Simplify and improve docker configuration

## 6.0.2 (2021-02-15)

Add `ENABLE_SLACK`, `ENABLE_GITHUB_AUTH` and `ENABLE_GITLAB_AUTH` environment variables


## 6.0.1 (2021-02-08)

Adatp to latest


## 6.0.0 (2021-02-02)

### Features

- main `docker-compose.yml` for Taiga installation

- `docker-compose-inits.yml` to run `python manage.py` with docker-compose
