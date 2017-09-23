ARG X_DCKR_TAG=xenial
FROM ubuntu:$X_DCKR_TAG

# Setup package manager
ARG DEBIAN_FRONTEND=noninteractive
#ADD ./sources.list /etc/apt/sources.list


RUN apt-get update -qqy && \
  apt-get install -y --allow-downgrades \
    tree realpath uuid-runtime moreutils
    sudo tree realpath \
    vim git curl dropbear python \
    build-essential uuid-runtime \
    python-tox \
    npm nodejs && \
  rm -rf /var/cache/apt/*

RUN npm install -g npm && \
    npm cache clean -f && \
    npm install -g n && \
    n stable

RUN \
    version="$(cd /usr/local/n/versions/node/; echo * | tr ' ' '\n' | sort -rn | head -n 1)"; \
    test -e /usr/bin/node || ln -sf /usr/local/n/versions/node/$version/bin/node /usr/bin/node


RUN cd /tmp/ && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py

RUN pip install \
	    setuptools PyYAML zope.interface zope.component objectpath

RUN \
  echo 'export PATH=$PATH:/usr/local/bin' > /etc/profile.d/ssh-environment; \
  mv /etc/profile /tmp/profile; \
  { echo 'export PATH=$PATH:/usr/local/bin'; \
    cat /tmp/profile; \
  } >/etc/profile




# Setup user
ARG username=treebox


RUN adduser --system --home /home/$username --shell /bin/bash --group $username
RUN echo "$username:$username" | chpasswd
RUN usermod $username -a -G sudo
RUN usermod $username -a -G staff

RUN mkdir -vp /home/$username/project

RUN git clone https://github.com/basherpm/basher.git /home/$username/.basher
RUN echo 'export PATH="$HOME/.basher/bin:$PATH"' >> /home/$username/.bash_profile

RUN chown -R $username:$username /home/$username/


USER $username

