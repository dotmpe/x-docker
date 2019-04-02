
FROM bvberkum/testbox:0.0.2

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
  org.label-schema.description="A bunch of py/rb/js dev tooling and a user setup" \
  org.label-schema.name="$IMAGE_NAME" \
  org.label-schema.build-date="$BUILD_DATE" \
  org.label-schema.version="$VERSION" \
  org.label-schema.vcs-ref=$GIT_SHA1 \
  org.label-schema.vcs-url="https://github.com/bvberkum/x-docker" \
  org.label-schema.schema-version="1.0"

USER root

# Setup package manager and install prerequisite packages
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get upgrade -qy -o Dpkg::Options::="--force-confold" && \
  apt-get install -qqy --allow-downgrades \
    bash zsh dash posh ash ksh mksh busybox-static \
    build-essential libreadline-dev time gawk  \
    bc curl elinks git jq graphviz imagemagick \
    libnet-ifconfig-wrapper-perl \
    make man moreutils netcat nodejs npm pandoc unrtf antiword \
    php-cli python python-dev python-tox python-yaml \
    realpath ruby-full rubygems socat sqlite3 ssh sudo tmux tree uuid-runtime \
    vim git-annex gist glances \
    software-properties-common \
    autoconf libtool \
    zlib1g wget libcurl4-openssl-dev libelf-dev libdw-dev cmake cmake-data g++ \
    binutils-dev \
    libiberty-dev zlib1g-dev \
    libzmq-dev \
    golang \
    && \
  unset DEBIAN_FRONTEND RUNLEVEL && \
  rm -rf /var/cache/apt/*

# Setup node NVM and some tooling
ARG node_version=lts

RUN npm install --quiet -g npm && \
      npm cache clean -qf && \
      npm install --quiet -g n && \
      n $node_version && \
  chmod g+rw /usr/local/* /usr/local/lib/node_modules && \
  chgrp staff /usr/local/* /usr/local/lib/node_modules && \
  version="$(cd /usr/local/n/versions/node/; echo * | tr ' ' '\n' | sort -rn | head -n 1)"; \
  { test -e /usr/bin/node || \
    ln -sf /usr/local/n/versions/node/$version/bin/node /usr/bin/node ; }

RUN npm install --quiet -g coffeescript pm2 grunt grunt-cli webpack node-gyp && \
  npm update --quiet -g nan && \
  npm install --quiet --unsafe-perm -g zmq && \
  gem install --quiet sass

# Install KCov
RUN git clone https://github.com/SimonKagstrom/kcov.git /src/github.com/SimonKagstrom/kcov && \
  cd /src/github.com/SimonKagstrom/kcov && \
  DEFAULT_KCOV_GIT_REF=$(git tag --list | grep "^v[0-9]\+$" | sort -V | tail --lines 1) && \
  KCOV_GIT_REF=${KCOV_GIT_REF:-$DEFAULT_KCOV_GIT_REF} && \
  git reset --hard $KCOV_GIT_REF && \
  mkdir build && cd build && cmake .. && make && make install

# TODO: fix pm2 fsevents
# TODO: accumulating current dev deps above. should split up into multiple bases and derivatives, one big one perhaps

# Fix permissions
ARG username=treebox

RUN \
  chown -R $username:$username /home/$username/ && \
  chown -R $username:staff /src/github.com /src/bitbucket.org /src/local /srv && \
  chmod -R g+rw /src/github.com /src/bitbucket.org /src/local

RUN locale-gen en_US.UTF-8

# Fancy up (root) env
ENV \
  TREEBOX_USER=$username \
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

USER $username

# Use Basher for lazy user-installs of new shell commands; it clones only the
# need last slice, no history, tags, etc. For non-user-command repos and full
# checkouts put stuff at /src/*.{net,org...tld}/<user>/<repo>.
#
# TODO: change from above manual installs to user-scripts repo
# XXX: see testbox
#RUN git clone https://github.com/basherpm/basher.git /home/$username/.basher && \
#  ( echo 'export PATH="$HOME/.basher/bin:$HOME/.basher/cellar/bin:$PATH"' >> /home/$username/.bash_profile ) && \
#  ( echo 'export PATH="$HOME/.basher/bin:$HOME/.basher/cellar/bin:$PATH"' >> /home/$username/.profile ) && \
#  ( echo ': "${CS:=dark}"; export CS' >> /home/$username/.bash_profile ) && \
#  ( echo ': "${TERM:=xterm}"; export TERM' >> /home/$username/.bash_profile ) && \
#  ( echo 'test -n "$CS" || CS=dark; export CS' >> /home/$username/.profile ) && \
#  ( echo 'test -n "$TERM" || TERM=xterm; export TERM' >> /home/$username/.profile ) && \
#  . ~/.profile && \
#  BASHER_FULL_CLONE=true basher install bvberkum/user-scripts && \
#  cd /home/$username/.basher/cellar/packages/bvberkum/user-scripts && \
#  git checkout r0.0 && \
#  mkdir -p /src/github.com/bvberkum && \
#  git clone https://github.com/bvberkum/oil.git /src/github.com/bvberkum/oil && \
#  cd /src/github.com/bvberkum/oil && \
#  git checkout feature/ast-visitor-cli && \
#  make configure && build/dev.sh minimal
#
#ENV TREEBOX_IMAGE="$IMAGE_NAME" \
#  TREEBOX_SOURCE="$SOURCE_BRANCH:$GIT_COMMIT" \
#  LANG=en_US.UTF-8 \
#  U_S=/home/$username/.basher/cellar/packages/bvberkum/user-scripts

# Id: x-docker/0.0.2-dev
