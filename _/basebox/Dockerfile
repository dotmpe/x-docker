
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
  org.label-schema.description="Fully upgraded phusion/baseimage" \
  org.label-schema.name="$IMAGE_NAME" \
  org.label-schema.build-date="$BUILD_DATE" \
  org.label-schema.version="$VERSION" \
  org.label-schema.vcs-ref=$GIT_COMMIT \
  org.label-schema.vcs-url="https://github.com/bvberkum/x-docker" \
  org.label-schema.schema-version="1.0"

# Upgrade with apt-get
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get upgrade -qy -o Dpkg::Options::="--force-confold" && \
  unset DEBIAN_FRONTEND RUNLEVEL && \
  rm -rf /var/cache/apt/*

# Id: x-docker/0.0.2-dev
