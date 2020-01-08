ARG X_DCKR_BASETAG=dev

FROM dotmpe/basebox:$X_DCKR_BASETAG

RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get install -qqy --allow-downgrades \
    dropbear socat netcat \
    build-essential python python3 python3-pip python3-pexpect \
    \
    gawk git-core diffstat unzip texinfo gcc-multilib \
    chrpath cpio pv file \
    xz-utils debianutils iputils-ping libsdl1.2-dev xterm tar locales

#    python-tox \
#    npm nodejs

# Auto dpkg-reconfigure dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections

# Set the locale to en_US.UTF-8
ARG L=en_US.UTF-8
RUN locale-gen $L && update-locale LC_ALL=$L LANG=$L
ENV LANG $L
ENV LC_ALL $L

#
