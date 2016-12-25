FROM resin/rpi-raspbian:jessie

MAINTAINER Mikael Hultgren <blomma@gmail.com>

ARG PYTHON_VERSION
ENV PYTHON_VERSION=${PYTHON_VERSION:-2.7.12}

COPY build.sh /build/

RUN /build/build.sh && rm -rf /build

COPY init.sh /init.sh
