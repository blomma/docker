#!/bin/sh -x

### CONFIG
export INITRD=no
export DEBIAN_FRONTEND=noninteractive

minimal_apt_get_args='-y --no-install-recommends'

BUILD_PACKAGES="build-essential make"


### PREPARE
apt-get update -y
apt-get install $minimal_apt_get_args $BUILD_PACKAGES


### BUILD
pip install unicornhat

### CLEANUP
apt-get remove --purge -y $BUILD_PACKAGES
apt-get autoremove --purge -y
apt-get clean all -y
rm -rf /var/lib/apt/lists/*
