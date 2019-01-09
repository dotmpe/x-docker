#!/bin/sh

set -e

echo '-------- Init ('$(date --iso=ns)')'


# Prepare user-scripts dep

# Override using preset SCRIPTPATH env
# Prefer submodule, then checkout
#curl -sSfo- https://rawgit.com/user-tools/user-scrips/master/tools/sh/init-...

test -n "$SCRIPTPATH" || {

  # Prefer submodule, then checkout
  test -d lib/user-scripts && {

    U_S=lib/user-scripts
  } || {

    test -e "/src/github.com/user-tools" && SRC_PREFIX=/src/github.com
    test -n "$SRC_PREFIX" || SRC_PREFIX=$HOME/build
    test -d $SRC_PREFIX/bvberkum/user-scripts || {

      mkdir -vp  $SRC_PREFIX/bvberkum || return
      git clone --depth 15 https://github.com/user-tools/user-scripts.git \
        $SRC_PREFIX/bvberkum/user-scripts
    }

    U_S=$SRC_PREFIX/bvberkum/user-scripts
  }
}

#scriptpath=$PWD/lib/sh
. $U_S/tools/sh/init.sh

echo Script-Path:
echo $SCRIPTPATH | tr ':' '\n'

#scriptpath=$PWD/lib/sh
#__load=ext . $scriptpath/load.lib.sh

#lib_load vc x-dckr date
#lib_init

echo 'Libs loaded'
