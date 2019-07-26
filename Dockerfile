FROM docker:latest

RUN apk add --no-cache py-pip python-dev libffi-dev openssl-dev git build-base bash gcc musl-dev go

# Install deploy dependencies.
#RUN pip install docker-compose awscli ecs-deploy

# Install golangci-lint
RUN wget -O - -q https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin v1.17.1;

ENV GOPATH /root/go
ENV CGO_ENABLED 0

# Install go-bindata
RUN go get github.com/jteeuwen/go-bindata/...

WORKDIR $GOPATH
