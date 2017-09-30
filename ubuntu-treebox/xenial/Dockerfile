ARG X_DCKR_TAG=xenial
FROM ubuntu:$X_DCKR_TAG

# Setup package manager
#ADD ./sources.list /etc/apt/sources.list
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get update -qqy && \
  apt-get install -qqy --allow-downgrades \
    bash posh dash \
    tree realpath uuid-runtime moreutils \
    sudo tree realpath \
    vim git curl dropbear \
    build-essential uuid-runtime \
    python python-tox \
    npm nodejs \
    ruby-full \
    php && \
  rm -rf /var/cache/apt/* && \
  \
  npm install --quiet -g npm && \
      npm cache clean -f && \
      npm install --quiet -g n && \
      n stable && \
  \
  chmod g+rw /usr/local/* /usr/local/lib/node_modules && \
  chgrp staff /usr/local/* /usr/local/lib/node_modules && \
  \
  version="$(cd /usr/local/n/versions/node/; echo * | tr ' ' '\n' | sort -rn | head -n 1)"; \
  { test -e /usr/bin/node || ln -sf /usr/local/n/versions/node/$version/bin/node /usr/bin/node ; }; \
  \
  cd /tmp/ && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py && \
  pip install --quiet \
  	    setuptools PyYAML zope.interface zope.component objectpath docutils && \
  for b in rst2html rst2xml rst2pxml; do \
    ln -s /usr/local/bin/$b.py /usr/local/bin/$b; done; \
  \
  npm install --quiet -g coffee-script pm2 grunt grunt-cli webpack && \
  gem install --quiet sass

# TODO: fix pm2 fsevents
# TODO: accumulating current dev deps above. should split up into multiple bases and derivatives, one big one perhaps

RUN \
  echo 'export PATH=$PATH:/usr/local/bin' > /etc/profile.d/ssh-environment; \
  mv /etc/profile /tmp/profile; \
  { echo 'export PATH=$PATH:/usr/local/bin'; \
    cat /tmp/profile; \
  } >/etc/profile


# Setup passwordless sudo
RUN \
  addgroup supergroup && \
  echo "%supergroup  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


# Setup user
ARG username=treebox
RUN \
  adduser --system --home /home/$username --shell /bin/bash --group $username && \
  ( echo "$username:$username" | chpasswd ) && \
  usermod $username -a -G sudo && \
  usermod $username -a -G staff && \
  usermod $username -a -G supergroup && \
  \
  mkdir -vp /home/$username/project && \
  git clone https://github.com/basherpm/basher.git /home/$username/.basher && \
  ( echo 'export PATH="$HOME/.basher/bin:$PATH"' >> /home/$username/.bash_profile ) && \
  \
  chown -R $username:$username /home/$username/


USER $username
# Id: x-docker/0.0.2-dev ./ubuntu-treebox/zesty/Dockerfile
