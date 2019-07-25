FROM golang:alpine

RUN apk add --no-cache docker py-pip python-dev libffi-dev openssl-dev build-base bash

# Install deploy dependencies.
RUN pip install docker-compose awscli ecs-deploy

# Install golangci-lint
RUN wget -O - -q https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin v1.17.1;

# Install go-bindata
RUN go get -u github.com/jteeuwen/go-bindata/...

RUN export GOPATH=$(go env GOPATH)

RUN echo $GOPATH

WORKDIR $GOPATH
