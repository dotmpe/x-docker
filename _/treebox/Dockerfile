
# Latest is 0.10.0 [2018-12-02] 
FROM phusion/baseimage:latest

MAINTAINER B. van Berkum <dev@dotmpe.com>

ARG X_DCKR_PREFIX=
ARG X_DCKR_BASENAME=
ARG X_DCKR_NAME=
ARG X_DCKR_BASE=
ARG X_DCKR_TAG=
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
  org.label-schema.vcs-ref=$GIT_COMMIT \
  org.label-schema.vcs-url="https://github.com/bvberkum/x-docker" \
  org.label-schema.schema-version="1.0"


# Setup package manager and install prerequisite packages
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
  apt-get install -qqy --allow-downgrades \
    bash zsh dash posh ash ksh mksh busybox-static \
    build-essential libreadline-dev time gawk  \
    bc curl elinks git jq graphviz imagemagick \
    figlet update-motd libnet-ifconfig-wrapper-perl \
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
  curl -s \
    https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | \
    bash && \
  apt-get update -qqy && \
  apt-get install -qqy git-lfs && \
  unset DEBIAN_FRONTEND RUNLEVEL && \
  rm -rf /var/cache/apt/*

# Setup node NVM and some tooling
ARG node_version=lts

RUN \
  npm install --quiet -g npm && \
      npm cache clean -f && \
      npm install --quiet -g n && \
      n $node_version && \
  chmod g+rw /usr/local/* /usr/local/lib/node_modules && \
  chgrp staff /usr/local/* /usr/local/lib/node_modules && \
  version="$(cd /usr/local/n/versions/node/; echo * | tr ' ' '\n' | sort -rn | head -n 1)"; \
  { test -e /usr/bin/node || \
    ln -sf /usr/local/n/versions/node/$version/bin/node /usr/bin/node ; }

# Setup python PIP and some tooling
RUN \
  cd /tmp/ && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py && \
  pip install --quiet \
    markdown BeautifulSoup mkdocs==0.17.5 \
  	setuptools PyYAML zope.interface zope.component objectpath docutils && \
  for b in rst2html rst2xml rst2pxml; do \
    ln -s /usr/local/bin/$b.py /usr/local/bin/$b; done

RUN \
  npm install --quiet -g coffeescript pm2 grunt grunt-cli webpack node-gyp && \
  npm update --quiet -g nan && \
  npm install --quiet --unsafe-perm -g zmq && \
  gem install --quiet sass

# Install KCov
RUN \
  git clone https://github.com/SimonKagstrom/kcov.git /src/github.com/SimonKagstrom/kcov && \
  cd /src/github.com/SimonKagstrom/kcov && \
  DEFAULT_KCOV_GIT_REF=$(git tag --list | grep "^v[0-9]\+$" | sort -V | tail --lines 1) && \
  KCOV_GIT_REF=${KCOV_GIT_REF:-$DEFAULT_KCOV_GIT_REF} && \
  git reset --hard $KCOV_GIT_REF && \
  mkdir build && cd build && cmake .. && make && make install

RUN \
  test -n "$BATS_REPO" || BATS_REPO=https://github.com/bvberkum/bats-core.git ; \
  test -n "$SRC_PREFIX" || SRC_PREFIX=/src/github.com/bvberkum ; \
  test -n "$BATS_BRANCH" || BATS_BRANCH=forks/bvb-dev ; \
  git clone $BATS_REPO $SRC_PREFIX/bats && \
  ( \
    cd $SRC_PREFIX/bats && \
    git checkout $BATS_BRANCH && \
    ./install.sh /usr/local \
  ) && \
  bats --version


# TODO: fix pm2 fsevents
# TODO: accumulating current dev deps above. should split up into multiple bases and derivatives, one big one perhaps

# Replace /etc/profile with local on PATH, because profile.d/ssh-env does not
# seem to do it.
RUN \
  echo 'export PATH=$PATH:/usr/local/bin' > /etc/profile.d/ssh-environment; \
  mv /etc/profile /tmp/profile; \
  { echo 'export PATH=$PATH:/usr/local/bin'; \
    cat /tmp/profile; \
  } >/etc/profile; \
  { \
    echo ; \
    echo "if test -e ~/.bashrc ; then source ~/.bashrc ; fi "; \
  } >> /etc/bash.bashrc; \

# Fancy up SSH
  figlet Treebox > /etc/ssh/banner && \
  echo "Banner /etc/ssh/banner" >> /etc/ssh/sshd_config

# TODO: And login (update-motd)
#RUN \
#  echo "" >> /etc/my_init.d


# Setup user and prepare for ssh, sudo
ARG username=treebox

RUN touch /etc/sudoers.d/treebox && { \
    echo "$username    ALL=NOPASSWD:/usr/sbin/service *"; \
    echo "$username    ALL=(www-data) NOPASSWD:ALL"; \
  } > /etc/sudoers.d/treebox; \
# FIXME: I don't think I should need or want to create a system-user, however
# usermod does not find the added user otherwise.
# Also fix permissions for /home, /src and /srv
  useradd -d /home/$username -s /bin/bash $username && \
  mkdir -vp /home/$username/project && \
  usermod $username -a -G sudo,staff,ssh && \
  ln -s /home/$username /srv/home-local && \
  ln -s /srv/home-local/project /srv/project-local && \
  ln -s /src /srv/src-local && \
  chown -R $username:$username /home/$username/ && \
  mkdir -vp /src/github.com /src/bitbucket.org /src/local /srv && \
  chown -R $username:staff /src/github.com /src/bitbucket.org /src/local /srv && \
  chmod -R g+rw /src/github.com /src/bitbucket.org /src/local && \
  chgrp staff /srv /etc/container_environment && \
  chmod -R g+rx /etc/container_environment


RUN locale-gen en_US.UTF-8

# Fancy up (root) env
ENV TREEBOX_USER=$username \
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
RUN git clone https://github.com/basherpm/basher.git /home/$username/.basher && \
  ( echo 'export PATH="$HOME/.basher/bin:$HOME/.basher/cellar/bin:$PATH"' >> /home/$username/.bash_profile ) && \
  ( echo 'export PATH="$HOME/.basher/bin:$HOME/.basher/cellar/bin:$PATH"' >> /home/$username/.profile ) && \
  ( echo ': "${CS:=dark}"; export CS' >> /home/$username/.bash_profile ) && \
  ( echo ': "${TERM:=xterm}"; export TERM' >> /home/$username/.bash_profile ) && \
  ( echo 'test -n "$CS" || CS=dark; export CS' >> /home/$username/.profile ) && \
  ( echo 'test -n "$TERM" || TERM=xterm; export TERM' >> /home/$username/.profile ) && \
  . ~/.profile && \
  BASHER_FULL_CLONE=true basher install bvberkum/user-scripts && \
  cd /home/$username/.basher/cellar/packages/bvberkum/user-scripts && \
  git checkout r0.0 && \
  mkdir -p /src/github.com/bvberkum && \
  git clone https://github.com/bvberkum/oil.git /src/github.com/bvberkum/oil && \
  cd /src/github.com/bvberkum/oil && \
  git checkout feature/ast-visitor-cli && \
  make configure && build/dev.sh minimal

ENV TREEBOX_IMAGE="$IMAGE_NAME" \
  TREEBOX_SOURCE="$SOURCE_BRANCH:$GIT_COMMIT" \
  LANG=en_US.UTF-8 \
  U_S=/home/$username/.basher/cellar/packages/bvberkum/user-scripts

# Id: x-docker/0.0.2-dev
