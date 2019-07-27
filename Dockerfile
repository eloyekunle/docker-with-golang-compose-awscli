FROM docker:latest

# Install Go
RUN apk add --no-cache ca-certificates bash git build-base python2

RUN echo 'hosts: files dns' > /etc/nsswitch.conf

RUN set -eux; \
	apk add --no-cache --virtual .build-deps \
		gcc \
		musl-dev \
		openssl \
		go \
		py-pip \
		python-dev \
		libffi-dev \
		openssl-dev \
		curl \
	; \
	export \
		GOROOT_BOOTSTRAP="$(go env GOROOT)" \
		GOOS="$(go env GOOS)" \
		GOARCH="$(go env GOARCH)" \
		GOHOSTOS="$(go env GOHOSTOS)" \
		GOHOSTARCH="$(go env GOHOSTARCH)" \
	; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		armhf) export GOARM='6' ;; \
		x86) export GO386='387' ;; \
	esac; \
	\
	export LATEST_GOLANG_VERSION=$(curl -s https://golang.org/dl/ | grep -m 1 -o 'go1\(\.[0-9]\+\)\+'); \
	wget -O go.tgz "https://golang.org/dl/$LATEST_GOLANG_VERSION.src.tar.gz"; \
	echo '95e8447d6f04b8d6a62de1726defbb20ab203208ee167ed15f83d7978ce43b13 *go.tgz' | sha256sum -c -; \
	tar -C /usr/local -xzf go.tgz; \
	rm go.tgz; \
	\
	cd /usr/local/go/src; \
	./make.bash; \
	\
	rm -rf \
		/usr/local/go/pkg/bootstrap \
		/usr/local/go/pkg/obj \
	; \
	\
	export PATH="/usr/local/go/bin:$PATH"; \
	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

# Install deploy dependencies.
RUN pip install docker-compose awscli ecs-deploy

# Delete virtual deps
RUN apk del .build-deps;
