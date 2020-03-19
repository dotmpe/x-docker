
ARG X_DCKR_BASETAG=dev

FROM dotmpe/treebox:$X_DCKR_BASETAG

MAINTAINER Docker Maintenance <docker-maint@dotmpe.com>

COPY docker-buildenv /etc/docker-buildenv

ARG DOCKER_IMAGE
ARG HUB_BUILD_TIME
ARG X_DCKR_COMMIT
ARG X_DCKR_VERSION

LABEL \
  org.label-schema.description="Docker on treebox" \
  org.label-schema.name="$DOCKER_IMAGE" \
  org.label-schema.build-date="$HUB_BUILD_TIME" \
  org.label-schema.version="$X_DCKR_VERSION" \
  org.label-schema.vcs-url="https://github.com/dotmpe/x-docker" \
  org.label-schema.vcs-ref=$X_DCKR_COMMIT \
  org.label-schema.schema-version="1.0"

USER root

# Setup package manager
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
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
