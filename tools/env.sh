#!/usr/bin/env bash

set -e -o pipefail -o nounset


# Determine workspace and relative CWD

test -n "${WORKSPACE:-}" || {
  test -n "${BUILD_CODE:-}" && {
    export WORKSPACE=/src/$BUILD_CODE
  }
}

test -n "${WORKSPACE:-}" || {
  test -n "${BUILD_PATH:-}" && {
    to_workspace=./$(printf -- "$BUILD_PATH" | cut -c2- | sed 's/[^/]*/../g')
    export WORKSPACE=$(cd $to_workspace && pwd)
  }
}

echo WORKSPACE: $WORKSPACE


# Init shell

test -e ./env.sh && {
  echo '--------------- loading local env'
  . ./env.sh
} || {
  echo '--------------- loading global env'
  . $WORKSPACE/tools/build-env.sh
}
