#!/usr/bin/env bash

set -e
cd "$( dirname "${BASH_SOURCE[0]}" )"

while read -r line; do
  VARNAME=$(echo ${line} | awk '{sub(/\=.*/,x)}1')

  if [[ -z ${!VARNAME} ]]; then
    declare -x ${line}
  fi
done < <(egrep -v "(^#|^\s|^$)" .env)

docker-compose up -d ${NODEDOCK_SERVICES}
docker-compose logs -t -f ${NODEDOCK_LOG_AFTER_START}
