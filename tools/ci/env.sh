#!/bin/sh

test -d lib/user-scripts && U_S=lib/user-scripts || {
  test -e "/src/github.com/user-tools" && SRC_PREFIX=/src/github.com
  test -n "$SRC_PREFIX" || SRC_PREFIX=$HOME/build
  U_S=$SRC_PREFIX/bvberkum/user-scripts
}

export LOG=$U_S/tools/sh/log.sh
export CS=dark
