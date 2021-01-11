#!/usr/bin/env sh
set -x
exec docker-compose -f docker-compose.yml -f docker-compose.penpot.yml up -d $@
