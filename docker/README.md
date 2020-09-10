# Deploy Taiga with Docker

## Requirements

Docker and docker-compose

Additionally, it's necessary to have familiarity with Docker, docker-compose and Docker repositories

## Customization

- share a configuration file (see example in `taiga-back/settings`) and set the proper `DJANGO_SETTINGS_MODULE` envvar
- modify `docker-compose.yml` as needed

## One shot commands

```sh
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-manage [COMMAND]
```

## Up

```sh
$ docker-compose up -d
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-migrate
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-collectstatic
```

This command, optional, creates an initial user (admin / 123123) and some sample data to test the environment.
```sh
$ docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-sampledata
```

Back/API exposes port 8000
