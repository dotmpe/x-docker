
ARG X_DCKR_BASETAG=master

FROM phusion/baseimage:$X_DCKR_BASETAG

MAINTAINER Docker Maintenance <docker-maint@dotmpe.com>

COPY docker-buildenv /etc/docker-buildenv
# XXX: no effect? RUN . /etc/docker-buildenv
ARG DOCKER_IMAGE
ARG HUB_BUILD_TIME
ARG X_DCKR_COMMIT
ARG X_DCKR_VERSION

LABEL \
  org.label-schema.description="Upgraded phusion/baseimage with some usertools" \
  org.label-schema.name="$DOCKER_IMAGE" \
  org.label-schema.build-date="$HUB_BUILD_TIME" \
  org.label-schema.version="$X_DCKR_VERSION" \
  org.label-schema.vcs-url="https://github.com/dotmpe/x-docker" \
  org.label-schema.vcs-ref=$X_DCKR_COMMIT \
  org.label-schema.schema-version="1.0"

# Upgrade with apt-get
# Then install minimal user tools
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get upgrade -qqy -o Dpkg::Options::="--force-confold" && \
  apt-get install -qqy --allow-downgrades \
    dash apt-transport-https bc wget curl git man jq ssh sudo tmux tree \
    uuid-runtime vim && \
  \
  cd /tmp && wget --quiet --content-disposition \
    "https://github.com/git-hooks/git-hooks/releases/download/v1.1.4/git-hooks_linux_amd64.tar.gz" && \
  tar xf git-hooks_linux_amd64.tar.gz && \
  mv build/git-hooks_linux_amd64 /usr/local/bin/git-hooks && \
  rm -rf build git-hooks_linux_amd64.tar.gz && \
  \
  apt-get clean autoclean && \
  apt-get autoremove -qqy && \
  unset DEBIAN_FRONTEND RUNLEVEL && \
  DEBIAN_FRONTEND=teletype \
  rm -Rf /usr/local/src/* -Rf && \
  rm -Rf /tmp/* && \
  rm -Rf /var/lib/apt/lists/*.gz && \
  rm -Rf /var/lib/cache/* && \
  rm -Rf /var/lib/log/* && \
  rm -Rf /var/log/* && \
  rm -Rf /var/cache/*

RUN locale-gen en_US.UTF-8

# Fancy up (root) env
ENV \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  DEBIAN_FRONTEND=teletype \
  DOCKER_IMAGE=$DOCKER_IMAGE


# Id: x-docker/0.0.2-dev
