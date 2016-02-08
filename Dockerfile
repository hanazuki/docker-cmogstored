FROM debian:jessie
MAINTAINER Kasumi Hanazuki <kasumi@rollingapple.net>

ENV CMOGSTORED_VERSION 1.5.0
ENV CMOGSTORED_SHA256SUM b83b954874ef201b6e6616ec3e60f517c6a01f7bc6eda1fbb3901558e34c1388

ADD ./setup.sh /tmp/setup.sh
RUN /tmp/setup.sh && rm /tmp/setup.sh

EXPOSE 7500 7501
VOLUME /var/mogdata

ENTRYPOINT ["/usr/local/bin/cmogstored"]
