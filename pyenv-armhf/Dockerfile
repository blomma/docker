FROM resin/rpi-raspbian:latest

ENV PYTHON_VERSION 3.6.0

COPY data/01_nodoc /etc/dpkg/dpkg.cfg.d/

COPY data/build.sh /build/
RUN /build/build.sh && rm -rf /build

COPY data/init.sh /init.sh
