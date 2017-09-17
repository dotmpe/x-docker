FROM debian:unstable
MAINTAINER B. van Berkum <dev@dotmpe.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -qqy \
      bash docker.io=1.12* && \
    rm -rf /var/cache/apt/*

CMD ["docker","-h"]
