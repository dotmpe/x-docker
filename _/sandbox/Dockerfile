
# Latest is 0.10.0
FROM bvberkum/treebox:latest

MAINTAINER B. van Berkum <dev@dotmpe.com>

LABEL \
  description="Docker on treebox" \
  urls.hub=https://hub.docker.com/r/bvberkum/sandbox \
  urls.repo=https://github.com/bvberkum/x-docker

USER root

# Setup package manager
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
  apt-get install -qqy --allow-downgrades \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common && \
  rm -rf /var/cache/apt/*

RUN \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
  add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable" ; \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get install -qqy docker-ce && \
  rm -rf /var/cache/apt/*

USER $username

ENV LANG=en_US.UTF-8

# Id: x-docker/0.0.2-dev
