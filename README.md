# Deploy Taiga with Docker

## Requirements

Docker and docker-compose

Additionally, it's necessary to have familiarity with Docker, docker-compose and Docker repositories

## Simple customization

There are some environment variables for a simple customization. Find them in the `docker-compose.yml`. The images are ready to work out of the box, although is strongly recommended to change some default values.

### Database: taiga-db

`POSTGRES_DB`, `POSTGRES_USER` and `POSTGRES_PASSWORD`. This vars will be used to create the database for Taiga.

**Important**: these vars should have the same values as `taiga-back` vars.

### API and Admin: taiga-back

`POSTGRES_DB`, `POSTGRES_USER` and `POSTGRES_PASSWORD`. This vars will be used to connect to the Taiga database.

**Important**: these vars should have the same values as `taiga-db` vars.

Besides, `POSTGRES_HOST` where the database is set. By default, it's meant to be in the same host as the database service so it uses internal docker names.

`TAIGA_PORT` should be the same as the exposed port in the `taiga-gateway`. Default is 9000.

`TAIGA_SECRET_KEY` should be the same as this var in `taiga-events`

`RABBITMQ_USER` and `RABBITMQ_PASS` are used to leave messages in rabbitmq.

### Front: taiga-front

`TAIGA_PORT` should be the same as the exposed port in the `taiga-gateway`. Default is 9000.

### Events: taiga-events

`TAIGA_SECRET_KEY` should be the same as this var in `taiga-back`

`RABBITMQ_USER` and `RABBITMQ_PASS` are used to read messages from rabbitmq.

## Complex customization

For a complex customization, you can use configuration files, mapped to a specific directories inside the containers.

### API and Admin: taiga-back

Map a Python configuration file to `/taiga-back/settings/config.py`. You can use (this file)[https://github.com/taigaio/taiga-back/blob/taiga-6/docker/config.py] as an example.

**Important**: if you use your own configuration file, don't forget to add contribs to `INSTALLED_APPS` (check the example `config.py`).

### Front: taiga-front

Map a `conf.json`configuration file to `/usr/share/nginx/html/conf.json`. You can use (this file)[https://github.com/taigaio/taiga-front/blob/taiga-6/docker/conf.json.template] as an example.

## Before running

You have to configure an admin user:
```sh
# ensure migrations are properly set
$ docker-compose up -d

$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-manage loaddata initial_user
# this command creates an admin/123123 user. Change it as soon as possible.
```

## Up and running

```sh
$ docker-compose up -d
```

Default access for the application is **http://localhost:9000**.

## One shot commands

```sh
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-manage [COMMAND]
```

## Sample data

This command, optional, some sample data to test the environment. It's important to run it **after running once the application** (which applies migrations). Otherwise, this command will fail.

```sh
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-sampledata
```
