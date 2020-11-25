# Deploy Taiga with Docker

## Requirements

Docker and docker-compose

Additionally, it's necessary to have familiarity with Docker, docker-compose and Docker repositories

## Simple customization

There are some environment variables for a simple customization. Find them in the `docker-compose.yml`. The images are ready to work out of the box, although is strongly recommended to change some default values.

### Database: taiga-db

`POSTGRES_DB`, `POSTGRES_USER` and `POSTGRES_PASSWORD`. This vars will be used to create the database for Taiga.

**Important**: these vars should have the same values as `taiga-back` vars.

### API, Admin, and Async: taiga-back

**Database settings**:

`POSTGRES_DB`, `POSTGRES_USER` and `POSTGRES_PASSWORD`. This vars will be used to connect to the Taiga database.

*Important*: these vars should have the same values as `taiga-db` vars.

Besides, `POSTGRES_HOST` where the database is set. By default, it's meant to be in the same host as the database service so it uses internal docker names.

**Taiga settings**:

`TAIGA_SECRET_KEY` should be the same as this var in `taiga-events` and `taiga-async`

`TAIGA_SITES_SCHEME` and `TAIGA_SITES_DOMAIN` should have the url where this is served: https[://]taiga.mycompany.com

**Email Settings**:

By default, email is configured with the *console* backend, which means that the emails will be shown in the stdout.
If you have an smtp service, configure `ENABLE_EMAIL` to "True" and the rest of email settings.

**Rabbit settings**

`RABBITMQ_USER` and `RABBITMQ_PASS` are used to leave messages in the rabbitmq services. Those variables should be the same as in `taiga-async-rabbitmq` and `taiga-events-rabbitmq`.

**Github settings**

Used for login with Github.
Get these in your profile https://github.com/settings/apps or in your organization profile https://github.com/organizations/{ORGANIZATION-SLUG}/settings/applications

**Gitlab settings**

Used for login with GitLab.
Get these in your profile https://{YOUR-GITLAB}/profile/applications or in your organization profile https://{YOUR-GITLAB}/admin/applications


### Front: taiga-front

`TAIGA_URL` where this Taiga instance should be served. It should be the same as `TAIGA_SITES_SCHEME`://`TAIGA_SITES_DOMAIN`.

`TAIGA_WEBSOCKETS_URL` to connect to the events. This should have the same value as `TAIGA_SITES_DOMAIN`, ie: ws://taiga.mycompany.com

**Github settings**

Used for login with Github.
Get these in your profile https://github.com/settings/apps or in your organization profile https://github.com/organizations/{ORGANIZATION-SLUG}/settings/applications

**Gitlab settings**

Used for login with GitLab.
Get these in your profile https://{YOUR-GITLAB}/profile/applications or in your organization profile https://{YOUR-GITLAB}/admin/applications


### Events: taiga-events

`TAIGA_SECRET_KEY` should be the same as this var in `taiga-back`

`RABBITMQ_USER` and `RABBITMQ_PASS` are used to read messages from rabbitmq.

## Complex customization

For a complex customization, you can use configuration files, mapped to a specific directories inside the containers.

**taiga-back**

Map a Python configuration file to `/taiga-back/settings/config.py`. You can use (this file)[https://github.com/taigaio/taiga-back/blob/taiga-6/docker/config.py] as an example.

*Important*: if you use your own configuration file, don't forget to add contribs to `INSTALLED_APPS` (check the example `config.py`).

**taiga-front**

Map a `conf.json`configuration file to `/usr/share/nginx/html/conf.json`. You can use (this file)[https://github.com/taigaio/taiga-front/blob/taiga-6/docker/conf.json.template] as an example.

## Before running

You have to configure an admin user:
```sh
# ensure migrations are properly set
$ docker-compose up -d

$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-manage createsuperuser
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
