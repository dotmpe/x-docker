
ARG X_DCKR_BASETAG=edge

FROM dotmpe/testbox:$X_DCKR_BASETAG

MAINTAINER Docker Maintenance <docker-maint@dotmpe.com>

ARG DOCKER_IMAGE
ARG BUILD_TIME
ARG X_DCKR_COMMIT
ARG X_DCKR_VERSION

LABEL \
  org.label-schema.description="A bunch of py/rb/js dev tooling and a user setup" \
  org.label-schema.name="$DOCKER_IMAGE" \
  org.label-schema.build-date="$BUILD_TIME" \
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
    php-cli python python-dev python-yaml \
    ruby-full rubygems socat sqlite3 ssh sudo tmux tree uuid-runtime \
    vim git-annex gist glances \
    software-properties-common \
    autoconf libtool \
    zlib1g wget libelf-dev libdw-dev cmake cmake-data g++ \
    binutils-dev \
    libiberty-dev zlib1g-dev \
    libzmq3-dev \
    golang \
    && \
  DEBIAN_FRONTEND=teletype \
  unset RUNLEVEL && \
  rm -rf /var/cache/apt/*

# Setup node NVM and some tooling
ARG node_version=lts

RUN npm install -g --quiet npm && \
  npm install -g --quiet n && \
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
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  cd /tmp/; \
  wget https://github.com/SimonKagstrom/kcov/releases/download/v40/kcov-amd64.tar.gz; \
  tar xzvf kcov-amd64.tar.gz -C /

# Install KCov (dev)
#RUN \
#  apt-get install -qqy --allow-downgrades \
#    libcurl4-openssl-dev && \
#  git clone https://github.com/SimonKagstrom/kcov.git /src/github.com/SimonKagstrom/kcov && \
#  cd /src/github.com/SimonKagstrom/kcov && \
#  DEFAULT_KCOV_GIT_REF=$(git tag --list | grep "^v[0-9]\+$" | sort -V | tail --lines 1) && \
#  KCOV_GIT_REF=${KCOV_GIT_REF:-$DEFAULT_KCOV_GIT_REF} && \
#  git reset --hard $KCOV_GIT_REF && \
#  mkdir build && cd build && cmake .. && make && make install

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
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get clean autoclean && \
  apt-get autoremove -qqy && \
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

# Use Basher (from testbox) for lazy user-installs of new shell commands; it
# clones only the need last slice, no history, tags, etc.
#
# TODO: change from above manual installs to user-scripts repo
# XXX: testing here, probably consolidate some into testbox, basebox...
# Should I use Docker ENV instead?
RUN { \
    echo 'export PATH="$HOME/.basher/bin:$HOME/.basher/cellar/bin:$PATH"';\
    echo 'test -n "${CS-}" || CS=dark; export CS'; \
    echo 'test -n "${TERM-}" || TERM=xterm; export TERM'; \
  } | tee -a /home/$username/.bash_profile | \
      tee -a /home/$username/.profile && \
  chown $username:$username /home/$username/.*profile; \
  mkdir -p /src/vendor/ /src/local/; \
  chgrp staff /src/local /src/vendor; \
  chmod g+rw /src/local /src/vendor;

USER $username

RUN \
  . ~/.profile && \
  BASHER_FULL_CLONE=true basher install dotmpe/user-scripts && \
  cd /home/$username/.basher/cellar/packages/dotmpe/user-scripts && \
  git checkout r0.0

RUN \
  . ~/.profile && \
  BASHER_FULL_CLONE=true basher install dotmpe/user-conf && \
  cd /home/$username/.basher/cellar/packages/dotmpe/user-conf && \
  git checkout r0.2

RUN \
  mkdir -p /src/vendor/github.com/dotmpe && \
  git clone https://github.com/dotmpe/oil.git /src/vendor/github.com/dotmpe/oil && \
  cd /src/vendor/github.com/dotmpe/oil && \
  git submodule update --init && \
  git checkout feature/ast-visitor-cli && \
  make configure && build/dev.sh minimal

USER root

RUN chgrp staff \
      /etc/profile /etc/bash.bashrc /etc/profile.d && \
  chmod g+rw \
      /etc/profile /etc/bash.bashrc /etc/profile.d

USER $username

#ENV TREEBOX_IMAGE="$IMAGE_NAME" \
#  TREEBOX_SOURCE="$SOURCE_BRANCH:$GIT_COMMIT" \
#  LANG=en_US.UTF-8 \
#  U_S=/home/$username/.basher/cellar/packages/dotmpe/user-scripts

# Id: x-docker/0.0.2-dev
