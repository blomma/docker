FROM blomma/pyenv-armhf:latest

COPY build.sh /build/

RUN . /init.sh && /build/build.sh && rm -rf /build
