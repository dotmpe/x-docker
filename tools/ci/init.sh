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
      #git clone --depth 15 https://github.com/user-tools/user-scripts.git \
      git clone https://github.com/dotmpe/user-scripts.git \
        $SRC_PREFIX/dotmpe/user-scripts
    }

    ( cd $SRC_PREFIX/dotmpe/user-scripts && git checkout feature/docker-ci )  || return

    U_S=$SRC_PREFIX/dotmpe/user-scripts
  }
}

( cd $U_S && git describe --always )

LOG=$U_S/tools/sh/log.sh INIT_LOG=$LOG
set -o nounset
SCRIPTPATH=$PWD/lib/sh
. $U_S/load.bash # setup SCRIPTPATH
. $U_S/tools/sh/util.sh # sh_include etc.
. $U_S/test/helper/extra.bash # get_uuid

. $U_S/tools/sh/init.sh # setup everything: lib_load, std libs, etc.

echo Script-Path:
echo $SCRIPTPATH | tr ':' '\n'

lib_load vc x-dckr date
# FIXME: lib_init

echo 'Libs loaded'
