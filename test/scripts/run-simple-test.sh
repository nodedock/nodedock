#!/usr/bin/env bash

set -e
cd "$( dirname "${BASH_SOURCE[0]}" )/../.."

docker-compose stop
docker-compose up -d nginx node workspace
docker-compose logs -f
