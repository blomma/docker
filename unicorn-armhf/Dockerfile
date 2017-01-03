FROM blomma/pyenv-3.6.0:latest

COPY build.sh /build/

RUN . /init.sh && /build/build.sh && rm -rf /build
