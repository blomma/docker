FROM arm32v7/debian:stretch-slim

ENV GOSU_VERSION 1.10
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.9.tar.gz
ENV REDIS_DOWNLOAD_SHA256 6eaacfa983b287e440d0839ead20c2231749d5d6b78bbe0e0ffa3a890c59ff26

RUN apt-get update -y
RUN apt-get install -y gcc libc6-dev wget ca-certificates make

RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

RUN set -ex \
	&& wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL" \
	&& echo "$REDIS_DOWNLOAD_SHA256 *redis.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h \
	&& sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h \
	&& grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install

FROM arm32v7/debian:stretch-slim

RUN groupadd -r redis && useradd -r -g redis redis

COPY --from=0 /usr/local/bin/redis-server /usr/local/bin
COPY --from=0 /usr/local/bin/redis-cli /usr/local/bin
COPY --from=0 /usr/local/bin/gosu /usr/local/bin

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 6379
CMD [ "redis-server"  ]
