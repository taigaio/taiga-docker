# Deploy Taiga with Docker

## Requirements

Docker and docker-compose

Additionally, it's necessary to have familiarity with Docker, docker-compose and Docker repositories

## Customization

- share a configuration file (see example in `taiga-back/settings`) and set the proper `DJANGO_SETTINGS_MODULE` envvar
- modify `docker-compose.yml` as needed

## Up

```sh
$ docker-compose up -d
```

Default port for the application is 9000.

## One shot commands

```sh
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-manage [COMMAND]
```

## Sample data

This command, optional, some sample data to test the environment. It's important to run it **after running once the application** (which applies migrations). Otherwise, this command will fail.
```sh
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-sampledata
```
