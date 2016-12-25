FROM blomma/pyenv-3.6.0:1.0.0

COPY build.sh /build/

RUN . /init.sh && /build/build.sh && rm -rf /build
