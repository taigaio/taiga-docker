#!/usr/bin/env sh
set -x
exec docker-compose -f docker-compose.yml -f docker-compose-inits.yml run --rm taiga-manage $@
