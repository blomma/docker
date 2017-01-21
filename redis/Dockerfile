FROM debian:jessie

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r redis && useradd -r -g redis redis

ENV GOSU_VERSION 1.10
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.2.6.tar.gz
ENV REDIS_DOWNLOAD_SHA1 0c7bc5c751bdbc6fabed178db9cdbdd948915d1b

COPY data/01_nodoc /etc/dpkg/dpkg.cfg.d/

COPY data/build.sh /build/

RUN /build/build.sh && rm -rf /build

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY data/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 6379
CMD [ "/usr/local/bin/redis-server"  ]
