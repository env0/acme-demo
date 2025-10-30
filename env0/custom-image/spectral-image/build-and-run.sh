#!/usr/bin/env bash
set -e

docker build --tag visa-image --progress plain -f Dockerfile .
docker run --rm -it --env-file "${ENV_FILE}" visa-image
