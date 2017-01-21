#!/bin/sh -x

### CONFIG
export INITRD=no
export DEBIAN_FRONTEND=noninteractive

minimal_apt_get_args='-y --no-install-recommends'

BUILD_PACKAGES="
	gcc
	libc6-dev
	wget
	ca-certificates
	make
"

RUNTIME_PACKAGES=""

### PREPARE
apt-get update -y
apt-get install $minimal_apt_get_args $BUILD_PACKAGES

set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

### BUILD
# for redis-sentinel see: http://redis.io/topics/sentinel
set -ex \
	&& wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL" \
	&& echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
	&& mkdir -p /usr/src/redis \
	&& tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
	&& rm redis.tar.gz \
	&& grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 1$' /usr/src/redis/src/server.h \
	&& sed -ri 's!^(#define CONFIG_DEFAULT_PROTECTED_MODE) 1$!\1 0!' /usr/src/redis/src/server.h \
	&& grep -q '^#define CONFIG_DEFAULT_PROTECTED_MODE 0$' /usr/src/redis/src/server.h \
	&& make -C /usr/src/redis \
	&& make -C /usr/src/redis install \
	&& rm -r /usr/src/redis

### CLEANUP
AUTO_ADDED_PACKAGES=`apt-mark showauto`
apt-get remove --purge -y $BUILD_PACKAGES $AUTO_ADDED_PACKAGES
apt-get clean all -y

### RUNTIME
apt-get install $minimal_apt_get_args $RUNTIME_PACKAGES

rm -rf /var/lib/apt/lists/*
