FROM debian:jessie
MAINTAINER Kasumi Hanazuki <kasumi@rollingapple.net>

ENV CMOGSTORED_VERSION 1.5.0
ENV CMOGSTORED_SHA256SUM b83b954874ef201b6e6616ec3e60f517c6a01f7bc6eda1fbb3901558e34c1388

RUN build_deps="gcc libc6-dev make wget" && \
    runtime_deps="sysstat" && \
    apt-get update && apt-get install --no-install-recommends -y $build_deps $runtime_deps && \
    file=cmogstored-${CMOGSTORED_VERSION}.tar.gz && \
    wget -qO /tmp/$file http://bogomips.org/cmogstored/files/$file && \
    echo "${CMOGSTORED_SHA256SUM} /tmp/$file" | sha256sum -c - && \
    srcdir=/usr/local/src/cgmostored-${CMOGSTORED_VERSION} && \
    mkdir -p $srcdir && tar xvf /tmp/$file -C $srcdir --strip-components=1 && rm -f /tmp/$file && \
    cd $srcdir && ./configure && make && make install && cd / && rm -rf $srcdir && \
    apt-get purge --auto-remove -y $build_deps && apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 7500 7501
VOLUME /var/mogdata

ENTRYPOINT ["/usr/local/bin/cmogstored"]
