# Docker with Docker Compose, AWS CLI and ECS Deploy image

[Docker image](https://hub.docker.com/_/docker/) with [Docker Compose](https://github.com/docker/compose) installed for CI.

## Supported tags and respective `Dockerfile` links

* [`latest` _(Dockerfile)_](https://github.com/eloyekunle/docker-with-compose-awscli/blob/master/Dockerfile)

## Description

For faster CI builds.

Contains:

- Go - Latest version
- [golangci-lint](https://github.com/golangci/golangci-lint)
- AWS CLI
- [ECS Deploy](https://github.com/fabfuel/ecs-deploy)
- Build Tools (`make` etc)

**GitHub repo**: <https://github.com/eloyekunle/docker-with-compose-awscli>

**Docker Hub image**: <https://hub.docker.com/r/playmice/docker-with-compose-awscli/>

## Usage

```bash
docker pull playmice/docker-with-compose-awscli
```
