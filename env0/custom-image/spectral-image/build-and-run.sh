#!/usr/bin/env bash
set -e

export USER_ID=2001210001

docker build --build-arg USER_ID=${USER_ID} --tag image-image --progress plain -f Dockerfile .
docker build --tag image-image-bundle --progress plain -f bundle.Dockerfile .

docker run --rm -it --read-only \
             -e STRICT_SECURITY_CONTEXT="true" \
            --tmpfs /tmp:uid=${USER_ID},gid=1000 --tmpfs /home/node:uid=${USER_ID},gid=1000 --tmpfs /opt/packages:uid=${USER_ID},gid=1000,exec  \
            --user ${USER_ID} --env-file "${ENV_FILE}" image-image-bundle
