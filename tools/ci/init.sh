#!/bin/sh

# Install U-S, and use tools/sh/init to get SCRIPTPATH env

echo '-------- Init ('$(date --iso=ns)')'


# Prepare user-scripts dep

# Override using preset SCRIPTPATH env
# Prefer submodule, then checkout
#curl -sSfo- https://rawgit.com/user-tools/user-scrips/master/tools/sh/init-...

test -n "${SCRIPTPATH:-}" || {

  # Prefer submodule, then checkout
  test -d lib/user-scripts && {

    U_S=lib/user-scripts
  } || {

    test -e "/src/github.com/user-tools" && SRC_PREFIX=/src/github.com
    true "${SRC_PREFIX:="$HOME/build"}"
    test -d $SRC_PREFIX/dotmpe/user-scripts || {

      mkdir -vp  $SRC_PREFIX/dotmpe || return
      git clone --depth 15 https://github.com/user-tools/user-scripts.git \
        $SRC_PREFIX/dotmpe/user-scripts
    }

    U_S=$SRC_PREFIX/dotmpe/user-scripts
  }
}

. $U_S/tools/sh/init.sh

set -o nounset

( cd $U_S && git describe --always )

echo Script-Path:
echo $SCRIPTPATH | tr ':' '\n'

#lib_load vc x-dckr date
#lib_init

echo 'Libs loaded'
