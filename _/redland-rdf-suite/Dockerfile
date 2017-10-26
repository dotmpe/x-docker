
FROM debian:sid


LABEL dc.description="Redland RDF suite on Debian"

# XXX: cleanup or implemented commented:
#ARG username=1701
ARG RDL_PREFIX=/usr/local


# Host pre-setup
RUN mkdir -vp /src/
#RUN chgrp staff /src /srv /usr/local/bin
#RUN chmod g+rw /src /srv /usr/local/bin


# Core tools
RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 apt-get install -y -qq \
    cron curl wget \
    python \
    make git \
    libtool \
    automake


# Install PIP
RUN curl https://bootstrap.pypa.io/get-pip.py -o /src/get-pip.py
RUN python /src/get-pip.py


#
# Redland install
#

COPY ./*.sh /tmp/
COPY ./requirements.txt /tmp/

RUN cd /tmp/ \
      && ./install-deps.sh \
      && ./install.sh $RDL_PREFIX

 
# TODO: Add main user

