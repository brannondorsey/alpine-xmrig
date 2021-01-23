FROM  alpine:latest
ARG   XMRIG_VERSION=v6.7.2

RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing hwloc-dev && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        build-base \
        openssl-dev \
        libmicrohttpd-dev && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      git checkout ${XMRIG_VERSION} && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make &&\
      apk del \
      build-base \
      cmake \
      git
USER miner
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig"]
