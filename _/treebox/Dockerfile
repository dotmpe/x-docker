
ARG X_DCKR_BASETAG=dev

FROM dotmpe/testbox:$X_DCKR_BASETAG

MAINTAINER Docker Maintenance <docker-maint@dotmpe.com>

COPY docker-buildenv /etc/docker-buildenv

ARG DOCKER_IMAGE
ARG HUB_BUILD_TIME
ARG X_DCKR_COMMIT
ARG X_DCKR_VERSION

LABEL \
  org.label-schema.description="A bunch of py/rb/js dev tooling and a user setup" \
  org.label-schema.name="$DOCKER_IMAGE" \
  org.label-schema.build-date="$HUB_BUILD_TIME" \
  org.label-schema.version="$X_DCKR_VERSION" \
  org.label-schema.vcs-url="https://github.com/dotmpe/x-docker" \
  org.label-schema.vcs-ref=$X_DCKR_COMMIT \
  org.label-schema.schema-version="1.0"

USER root

# Setup package manager and install prerequisite packages
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get install -qqy --allow-downgrades \
    bash zsh dash posh ash ksh mksh busybox-static \
    build-essential libreadline-dev time gawk  \
    bc curl elinks git jq graphviz imagemagick \
    libnet-ifconfig-wrapper-perl \
    make man moreutils netcat npm pandoc unrtf antiword \
    php-cli python python-dev python-tox python-yaml \
    ruby-full rubygems socat sqlite3 ssh sudo tmux tree uuid-runtime \
    vim git-annex gist glances \
    software-properties-common \
    autoconf libtool \
    zlib1g wget libelf-dev libdw-dev cmake cmake-data g++ \
    binutils-dev \
    libiberty-dev zlib1g-dev \
    libzmq3-dev \
    golang

# Setup node NVM and some tooling
ARG node_version=lts

RUN npm install -g npm && \
  npm install -g n && \
  n $node_version && \
  chmod g+rw /usr/local/* /usr/local/lib/node_modules && \
  chgrp staff /usr/local/* /usr/local/lib/node_modules && \
  nodepath=$(echo /usr/local/n/versions/node/*/bin | tr ' ' '\n' | sort -rn | head -n 1) && \
  export PATH=$nodepath:$PATH && \
  { echo; echo PATH=$PATH; } | tee -a /etc/profile | tee -a /etc/bash.bashrc

RUN npm install --quiet -g coffeescript pm2 grunt grunt-cli webpack node-gyp && \
  npm update --quiet -g nan && \
  gem install --quiet sass

#  npm install --quiet --unsafe-perm -g zmq && \

# Install KCov
RUN \
  git clone https://github.com/SimonKagstrom/kcov.git /src/github.com/SimonKagstrom/kcov && \
  cd /src/github.com/SimonKagstrom/kcov && \
  DEFAULT_KCOV_GIT_REF=$(git tag --list | grep "^v[0-9]\+$" | sort -V | tail --lines 1) && \
  KCOV_GIT_REF=${KCOV_GIT_REF:-$DEFAULT_KCOV_GIT_REF} && \
  git reset --hard $KCOV_GIT_REF && \
  mkdir build && cd build && cmake .. && make && make install

# TODO: fix pm2 fsevents
# TODO: accumulating current dev deps above. should split up into multiple bases and derivatives, one big one perhaps

# TODO: Fix permissions for above paths, ie. set to grp:staff?
ARG username=treebox

RUN \
  chown -R $username:$username /home/$username/ && \
  chown -R $username:staff /src/github.com /src/bitbucket.org /src/local /srv && \
  chmod -R g+rw /src/github.com /src/bitbucket.org /src/local

RUN locale-gen en_US.UTF-8

RUN \
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

# Fancy up (root) env
ENV \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  DEBIAN_FRONTEND=teletype \
  DOCKER_IMAGE=$DOCKER_IMAGE

# Use 'sudo -iHu <user>'
USER root

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
#  BASHER_FULL_CLONE=true basher install dotmpe/user-scripts && \
#  cd /home/$username/.basher/cellar/packages/dotmpe/user-scripts && \
#  git checkout r0.0 && \
#  mkdir -p /src/github.com/dotmpe && \
#  git clone https://github.com/dotmpe/oil.git /src/github.com/dotmpe/oil && \
#  cd /src/github.com/dotmpe/oil && \
#  git checkout feature/ast-visitor-cli && \
#  make configure && build/dev.sh minimal
#
#ENV TREEBOX_IMAGE="$IMAGE_NAME" \
#  TREEBOX_SOURCE="$SOURCE_BRANCH:$GIT_COMMIT" \
#  LANG=en_US.UTF-8 \
#  U_S=/home/$username/.basher/cellar/packages/dotmpe/user-scripts

# Id: x-docker/0.0.2-dev
