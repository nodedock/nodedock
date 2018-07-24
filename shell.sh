#!/usr/bin/env bash

set -e
cd "$( dirname "${BASH_SOURCE[0]}" )"
docker-compose exec workspace bash
