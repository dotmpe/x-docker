#!/bin/sh

set -e


# build-essentials libtoolize

apt-get install -y \
  automake gtk-doc-tools \
  python \
  librasqal3 librasqal3-dev \
  libraptor1 libraptor1-dev


pip install -r requirements.txt


