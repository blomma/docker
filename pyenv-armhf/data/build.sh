#!/bin/sh -x

### CONFIG
export INITRD=no
export DEBIAN_FRONTEND=noninteractive

minimal_apt_get_args='-y --no-install-recommends'

BUILD_PACKAGES="
	build-essential
	ca-certificates
	curl
	git
	libbz2-dev
	libncurses5-dev
	libreadline-dev
	libsqlite3-dev
	libssl-dev
	make
	wget
	zlib1g-dev
"


### PREPARE
apt-get update -y
apt-get install $minimal_apt_get_args $BUILD_PACKAGES


### BUILD
git clone --depth 1 https://github.com/yyuu/pyenv.git ~/.pyenv
rm -rfv /root/.pyenv/.git

export PYENV_ROOT="/root/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
pip install --upgrade pip
pyenv rehash


### CLEANUP
apt-get remove --purge -y $BUILD_PACKAGES
apt-get autoremove --purge -y
apt-get clean all -y
rm -rf /var/lib/apt/lists/*
