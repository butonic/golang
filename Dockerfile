FROM webhippie/alpine:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

VOLUME ["/srv/app"]

WORKDIR /srv/app
CMD ["bash"]

ENV GOPATH /srv/app
ENV GO15VENDOREXPERIMENT 1

ENV PATH ${GOPATH}/bin:/usr/local/go/bin:${PATH}

ENV GOLANG_VERSION 1.7rc2
ENV GOLANG_TARBALL https://golang.org/dl/go$GOLANG_VERSION.src.tar.gz

RUN apk update && \
  apk add \
    build-base \
    git \
    mercurial \
    bzr \
    go && \
  export \
    GOROOT_BOOTSTRAP="$(go env GOROOT)" && \
  curl -sLo - \
    ${GOLANG_TARBALL} | tar -xzf - -C /usr/local && \
  cd \
    /usr/local/go/src && \
  bash \
    make.bash && \
  apk del \
    go && \
  rm -rf \
    /var/cache/apk/*

ADD rootfs /
