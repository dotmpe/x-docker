
ARG X_DCKR_BASETAG=dev

FROM dotmpe/basebox:$X_DCKR_BASETAG

MAINTAINER Docker Maintenance <docker-maint@dotmpe.com>

COPY docker-buildenv /etc/docker-buildenv

ARG DOCKER_IMAGE
ARG HUB_BUILD_TIME
ARG X_DCKR_COMMIT
ARG X_DCKR_VERSION

LABEL \
  org.label-schema.description="smaller baseimage for treebox" \
  org.label-schema.name="$DOCKER_IMAGE" \
  org.label-schema.build-date="$HUB_BUILD_TIME" \
  org.label-schema.version="$X_DCKR_VERSION" \
  org.label-schema.vcs-url="https://github.com/dotmpe/x-docker" \
  org.label-schema.vcs-ref=$X_DCKR_COMMIT \
  org.label-schema.schema-version="1.0"

# Setup package manager and install prerequisite packages
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get install -qqy --allow-downgrades \
    bash zsh dash posh ash busybox-static \
    build-essential time gawk  \
    bc curl elinks git jq graphviz imagemagick \
    figlet update-motd \
    make man moreutils netcat pandoc unrtf antiword \
    python python-dev python-tox python-yaml \
    sqlite3 ssh sudo tmux tree uuid-runtime \
    vim git-annex gist glances \
    software-properties-common \
    autoconf libtool \
    zlib1g wget cmake g++ \
    golang


# Setup python PIP and some tooling
RUN cd /tmp/ && \
      curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
      python get-pip.py && rm get-pip.py && \
  pip install --quiet \
    markdown BeautifulSoup mkdocs==0.17.5 \
    setuptools PyYAML zope.interface zope.component objectpath docutils && \
  for b in rst2html rst2xml rst2pxml; do \
    ln -s /usr/local/bin/$b.py /usr/local/bin/$b; done


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

# Add /usr/local/bin for SSH and normal profile
# and include .bashrc from /etc/bash.bashrc
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

RUN \
  touch /etc/sudoers.d/treebox && { \
    echo "$username    ALL=NOPASSWD:/usr/sbin/service *"; \
    echo "$username    ALL=(www-data) NOPASSWD:ALL"; \
  } > /etc/sudoers.d/treebox; \
# FIXME: I don't think I should need or want to create a system-user, however
# usermod does not find the added user otherwise.
# Also fix permissions for /home, /src and /srv
  useradd -d /home/$username -s /bin/bash $username && \
  mkdir -vp \
    /home/$username/.local/etc \
    /home/$username/.local/var \
    /home/$username/.local/usr \
    /home/$username/project && \
  usermod $username -a -G sudo,staff,ssh && \
  ln -s /home/$username /srv/home-local && \
  ln -s /srv/home-local/project /srv/project-local && \
  ln -s /src /srv/src-local && \
  chown -R $username:$username /home/$username/ && \
  # Setup /srv/src-local and permissions
  mkdir -vp /src/github.com /src/bitbucket.org /src/local /srv && \
  chown -R $username:staff /src/github.com /src/bitbucket.org /src/local /srv && \
  chmod -R g+rw /src/github.com /src/bitbucket.org /src/local && \
  chgrp staff /srv /etc/container_environment /etc/sudoers.d/README && \
  chmod -R g+rx /etc/container_environment && \
  chmod g+r /etc/sudoers.d/README


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
  LC_ALL=en_US.UTF-8 \
  DEBIAN_FRONTEND=teletype \
  DOCKER_IMAGE=$DOCKER_IMAGE

USER $username

# Use Basher for lazy user-installs of new shell commands; it clones only the
# need last slice, no history, tags, etc. For non-user-command repos and full
# checkouts put stuff at /src/*.{net,org...tld}/<user>/<repo>.
#
# TODO: change from above manual installs to user-scripts repo
RUN \
  git clone https://github.com/basherpm/basher.git /home/$username/.basher && \
  PATH="$HOME/.basher/bin:$HOME/.basher/cellar/bin:$PATH" basher install erichs/composure

# Use 'sudo -iHu <user>'
USER root

# Derive: _/treebox/Dockerfile
# Id: x-docker/0.0.2-dev
