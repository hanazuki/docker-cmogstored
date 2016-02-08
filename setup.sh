#!/bin/bash

set -e

build_deps=(gcc libc6-dev make wget)
runtime_deps=(sysstat)

apt-get update
apt-get install --no-install-recommends -y "${build_deps[@]}" "${runtime_deps[@]}"

file=cmogstored-${CMOGSTORED_VERSION}.tar.gz
url=http://bogomips.org/cmogstored/files/$file
wget -qO /tmp/"$file" "$url"
echo "${CMOGSTORED_SHA256SUM} /tmp/$file" | sha256sum -c -

srcdir=/usr/local/src/cgmostored-${CMOGSTORED_VERSION}
mkdir -p "$srcdir"
tar xvf /tmp/"$file" -C "$srcdir" --strip-components=1
rm -f /tmp/"$file"

cd "$srcdir"
./configure
make
make install

cd /
rm -rf "$srcdir"

apt-get purge --auto-remove -y "${build_deps[@]}"
apt-get clean
rm -rf /var/lib/apt/lists/*
