ARG REDIS_VERSION
FROM redis:${REDIS_VERSION}-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && apk add gcc g++ libc-dev wget vim openssl-dev make linux-headers bash \
  && rm -rf /var/cache/apk/*

RUN mkdir /log && chown redis:redis /log \
    && mkdir -p /usr/src/sh  && chown redis:redis /usr/src/sh

COPY redis.sh   /usr/src/sh
RUN  chmod +x  /usr/src/sh/redis.sh