#! /usr/bin/env bash

export HOST_UID=$(id -u)
export HOST_GID=$(id -g)

if command -v podman-compose &> /dev/null; then
    export PODMAN_USERNS=keep-id
    podman-compose --in-pod false up "$@"
else
    docker-compose up "$@"
fi

