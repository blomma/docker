FROM resin/rpi-raspbian:latest

MAINTAINER Mikael Hultgren <blomma@gmail.com>

ARG PYTHON_VERSION
ENV PYTHON_VERSION=${PYTHON_VERSION:-3.6.0}

COPY build.sh /build/

RUN /build/build.sh && rm -rf /build

COPY init.sh /init.sh
