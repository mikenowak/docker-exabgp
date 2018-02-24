FROM alpine:3.7
MAINTAINER Mike Nowak <https://github.com/mikenowak>

RUN apk --no-cache add wget curl python python-dev py-setuptools coreutils netcat-openbsd bash \
    && apk --no-cache add --virtual build-dependencies build-base py-pip  \
    && mkdir -p /usr/etc/exabgp \
    && pip install ipaddr exabgp ipy requests \
    && apk del build-dependencies 

ADD entrypoint.sh /
ADD exabgp.conf.example /usr/etc/exabgp/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["exabgp"]
VOLUME ["/usr/etc/exabgp"]
EXPOSE 179
