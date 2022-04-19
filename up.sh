#!/bin/sh
docker-compose --env-file .env -f compose/development.yml up --detach 