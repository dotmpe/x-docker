#!/bin/sh

set -e

test -n "$1" || set -- /usr/local
test -w $1 -o -n "$sudo" || sudo=sudo


mkdir -v $HOME/build
cd $HOME/build/
git clone https://github.com/dajobe/librdf.git
cd $HOME/build/librdf


./autogen.sh --prefix=$1
./configure --prefix=$1
make
make check
$sudo make install

