
# Latest is 0.10.0 [2018-12-02]
FROM phusion/baseimage:latest

MAINTAINER B. van Berkum <dev@dotmpe.com>

ARG BUILD_DATE=
ARG BUILD_CODE=
ARG IMAGE_NAME=
ARG GIT_COMMIT=
ARG COMMIT_MSG=
ARG VERSION=

LABEL \
  org.label-schema.description="Fully upgraded phusion/baseimage and usertools" \
  org.label-schema.name="$IMAGE_NAME" \
  org.label-schema.build-date="$BUILD_DATE" \
  org.label-schema.version="$VERSION" \
  org.label-schema.vcs-ref=$GIT_COMMIT \
  org.label-schema.vcs-url="https://github.com/bvberkum/x-docker" \
  org.label-schema.schema-version="1.0"

# Upgrade with apt-get
# Then install minimal user tools
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get upgrade -qy -o Dpkg::Options::="--force-confold" && \
  apt-get install -qqy --allow-downgrades \
    bash zsh dash posh ash busybox-static \
    apt-transport-https \
    bc curl git \
    ssh sudo tmux tree uuid-runtime \
    vim git-annex \
  curl -s \
    https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | \
    bash && \
  apt-get update -qqy && \
  apt-get install -qqy git-lfs && \
  cd /tmp && wget --quiet --content-disposition \
    "https://github.com/git-hooks/git-hooks/releases/download/v1.1.4/git-hooks_linux_amd64.tar.gz" && \
  tar xf git-hooks_linux_amd64.tar.gz && \
  mv build/git-hooks_linux_amd64 /usr/local/bin/git-hooks && \
  rm -rf build git-hooks_linux_amd64.tar.gz && \
  unset DEBIAN_FRONTEND RUNLEVEL && \
  rm -rf /var/cache/apt/*

RUN locale-gen en_US.UTF-8

# Id: x-docker/0.0.2-dev
