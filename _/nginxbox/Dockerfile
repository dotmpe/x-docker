
ARG X_DCKR_BASETAG=dev

FROM dotmpe/basebox:$X_DCKR_BASETAG

MAINTAINER Docker Maintenance <docker-maint@dotmpe.com>

ARG DOCKER_IMAGE
ARG BUILD_TIME
ARG X_DCKR_COMMIT
ARG X_DCKR_VERSION

LABEL \
  org.label-schema.description="An NGINX/PHP/MySQL deployment box" \
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
  add-apt-repository -y ppa:ondrej/php && \
  apt-get update -qqy && \
  apt-get install -qqy --allow-downgrades \
    nginx mariadb-server rsync vim elinks tidy mailutils \
    php7.4 \
    php7.4-bcmath \
    php7.4-cli \
    php7.4-curl \
    php7.4-dev \
    php7.4-fpm \
    php7.4-gd \
    php7.4-imap \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-mcrypt \
    php7.4-mysql \
    php7.4-simplexml \
    php7.4-soap \
    php7.4-xml \
    php7.4-zip

RUN \
  tz=Europe/Amsterdam && \
  cp -vf /usr/share/zoneinfo/$tz /etc/localtime && \
  echo $tz >/etc/timezone && \
  phpenmod mcrypt && \
  phpenmod imap && \
  mkdir /run/php && \
  rm -f /etc/service/sshd/down && \
  cd /root && \
    curl -sS https://getcomposer.org/installer -o composer-setup.php && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Cleanup after installations all done
RUN \
  DEBIAN_FRONTEND=noninteractive; RUNLEVEL=1; \
  apt-get autoclean -qqy && \
  apt-get autoremove -qqy && \
  rm -Rf /usr/local/src/* && \
  rm -Rf /tmp/* && \
  rm -Rf /var/lib/apt/lists/*.gz && \
  rm -Rf /var/lib/cache/* && \
  rm -f /var/lib/log/*.log* && \
  rm -f /var/log/*.log* && \
  rm -Rf /var/cache/*

# Setup env, SSH
COPY ssh-banner /etc/ssh/banner
RUN \
  echo 'export PATH=$PATH:/usr/local/bin' > /etc/profile.d/ssh-environment && \
  mv /etc/profile /tmp/profile && \
  { echo 'export PATH=$PATH:/usr/local/bin'; \
    cat /tmp/profile; \
  } >/etc/profile && rm /tmp/profile && \
  { \
    echo ; \
    echo "if test -e ~/.bashrc ; then source ~/.bashrc ; fi "; \
  } >> /etc/bash.bashrc && \
  echo "Banner /etc/ssh/banner" >> /etc/ssh/sshd_config

RUN { \
    echo "#!/bin/sh"; \
    echo "test -e /etc/ssl/certs/dhparam.pem ||"; \
    echo "  openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096"; \
  } > /etc/my_init.d/00_regen_ssl_pem.sh && \
  \
  chmod u+x \
    /etc/my_init.d/00_regen_ssl_pem.sh

# Set startup services
RUN { \
    echo "#!/bin/sh"; \
    echo "service postfix start"; \
    echo "service nginx start"; \
    echo "service php7.4-fpm start"; \
    echo "service mysql start"; \
  } > /etc/my_init.d/20_nginxbox_services.sh && \
  \
  chmod u+x \
    /etc/my_init.d/20_nginxbox_services.sh

# Setup user and prepare for ssh, sudo
ARG username=boxuser

RUN \
  touch /etc/sudoers.d/boxuser && { \
    echo "$username    ALL=NOPASSWD:/usr/sbin/service *"; \
    echo "$username    ALL=(www-data) NOPASSWD:ALL"; \
  } > /etc/sudoers.d/boxuser ; \
  adduser --disabled-password --gecos '' $username && \
  mkdir -vp \
    /home/$username/.ssh \
    /home/$username/.local/etc \
    /home/$username/.local/var \
    /home/$username/.local/usr && \
  chown -R $username:$username /home/$username/

EXPOSE 22 80 443 3306

# Id: x-docker/0.0.2-dev
