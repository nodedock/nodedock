#!/usr/bin/env bash

set -e
cd "$( dirname "${BASH_SOURCE[0]}" )"
while read -r line; do declare -x "$line"; done < <(egrep -v "(^#|^\s|^$)" .env)
docker-compose up -d $NODEDOCK_SERVICES
