FROM debian:unstable
MAINTAINER B. van Berkum <dev@dotmpe.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -qqy \
      bash docker.io && \
    rm -rf /var/cache/apt/*

CMD ["docker","-h"]
# Id: x-docker/0.0.1 ./debian-docker/unstable/Dockerfile
