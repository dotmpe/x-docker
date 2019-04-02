
ARG X_DCKR_BASETAG=master

# Tag 'latest' is 0.10.0
# Last version is 0.11
# Newest version is 'master'
FROM phusion/baseimage:$X_DCKR_BASETAG

MAINTAINER B. van Berkum <dev@dotmpe.com>

ARG X_DCKR_PREFIX=
ARG X_DCKR_BASENAME=
ARG X_DCKR_NAME=
ARG X_DCKR_AI_TIME=
ARG X_DCKR_CI_TIME=
ARG X_DCKR_RELEASE=
ARG BUILD_CODE=
ARG IMAGE_NAME=
ARG DOCKER_TAGS=
ARG DOCKER_TAG=
ARG SOURCE_TYPE=
ARG SOURCE_BRANCH=
ARG GIT_SHA1=
ARG COMMIT_MSG=
ARG BUILD_DATE=
ARG VERSION=

LABEL \
  org.label-schema.description="Fully upgraded phusion/baseimage and usertools" \
  org.label-schema.name="$IMAGE_NAME" \
  org.label-schema.build-date="$BUILD_DATE" \
  org.label-schema.version="$VERSION" \
  org.label-schema.vcs-ref=$GIT_SHA1 \
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
    bc curl git man jq \
    ssh sudo tmux tree uuid-runtime \
    vim git-annex \
    && \
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

# Fancy up (root) env
ENV \
  TREEBOX_BUILD_ID="$BUILD_CODE" \
  TREEBOX_IMAGE="$IMAGE_NAME:$DOCKER_TAG" \
  TREEBOX_SOURCE="$SOURCE_BRANCH:$GIT_SHA1" \
  X_DCKR_AI_TIME="$X_DCKR_AI_TIME" \
  X_DCKR_CI_TIME="$X_DCKR_CI_TIME" \
  TREEBOX_TAGS="$DOCKER_TAGS" \
  TREEBOX_TAG="$DOCKER_TAG" \
  TREEBOX_BUILD_TIME="$BUILD_DATE" \
  TREEBOX_BUILD="$X_DCKR_RELEASE" \
  TREEBOX_VERSION="$VERSION" \
  TREEBOX_SCM=$SOURCE_TYPE \
  TREEBOX_SCM_BRANCH="$SOURCE_BRANCH" \
  TREEBOX_SCM_COMMIT="$GIT_SHA1" \
  TREEBOX_SCM_COMMIT_MSG="$COMMIT_MSG" \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8


# Id: x-docker/0.0.2-dev
