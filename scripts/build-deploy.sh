#!/usr/bin/env bash
set -e

docker build -t playmice/docker-with-compose-awscli .

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push playmice/docker-with-compose-awscli
