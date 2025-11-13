#!/usr/bin/env bash
set -e

export USER_ID=1003050001

docker build --build-arg USER_ID=${USER_ID} --tag local-image --progress plain -f Dockerfile .
docker build --tag local-image-bundle --progress plain -f bundle.Dockerfile .

docker run --rm -it --read-only \
             -e STRICT_SECURITY_CONTEXT="true" \
            --tmpfs /tmp:uid=${USER_ID},gid=1000,exec --tmpfs /home/node:uid=${USER_ID},gid=1000,exec --tmpfs /opt/packages:uid=${USER_ID},gid=1000,exec  \
            --user ${USER_ID} --env-file "${ENV_FILE}" local-image
