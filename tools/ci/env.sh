#!/bin/sh

# Prepare env and a symlink or two

set -eo pipefail -o posix

test -d lib/user-scripts \
  && U_S=lib/user-scripts \
  || {
    test -e "/src/github.com/user-tools" && SRC_PREFIX=/src/github.com
    true "${SRC_PREFIX:="$HOME/build"}"
    U_S=$SRC_PREFIX/bvberkum/user-scripts
  }

export LOG=$U_S/tools/sh/log.sh
export CS=dark
